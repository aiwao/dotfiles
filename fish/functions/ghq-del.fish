function ghq-del --description "Delete a ghq directory and a GitHub repo"
    if test (count $argv) -eq 0
        echo "please enter the repository name"
        return 1
    end

    set -l project $argv[1]
    
    gh repo delete $project
    or return 1
    ghq rm $project
end
