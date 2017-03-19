_dotnet()
{
    local cur prev prev2 cmd opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    prev2="${COMP_WORDS[COMP_CWORD-2]}"
    cmd=$"${COMP_WORDS[1]}"

    case "${cmd}" in
      new)
        if [[ ${prev} == new ]] ; then
          opts="console classlib mstest xunit web mvc webapi sln"
          COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
          return 0
        fi

        if [[ ${cur} == -* ]] ; then
          opts="--list --language --name --output --help"
          COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
          return 0
        fi

        onlycs="web webapi";
        if [[ ${prev} == --language && $onlycs == *${prev2}* ]] ; then
          opts="C#"
          COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
          return 0
        fi

        if [[ ${prev} == --language ]] ; then
          opts="C# F#"
          COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
          return 0
        fi
        ;;

      add)
        if [[ ${prev} == add ]] ; then
          opts="package reference"
          COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
          return 0
        fi

        if [[ ${prev} == package ]] ; then
          opts="$(curl -s https://api-v2v3search-0.nuget.org/autocomplete?q=${cur} | grep -Po '\[.*?\]' | grep -Po '(?<=").*?(?=")')"
          COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
          return 0
        fi

        if [[ ${cur} == -* ]] ; then
          opts="--version"
          COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
          return 0
        fi

        if [[ ${prev} == --version ]] ; then
          opts="$(curl -s https://api-v2v3search-0.nuget.org/autocomplete?id=${prev2} | grep -Po '\[.*?\]' | grep -Po '(?<=").*?(?=")' | grep -Po '^[^,]+$' | sort)"
          COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
          return 0
        fi
        ;;
      *)
      ;;
    esac

    if [[ ${prev} == dotnet ]] ; then
      opts="new restore build publish run test pack migrate clean sln add remove list"
      COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
      return 0
    fi
   
}

complete -F _dotnet dotnet