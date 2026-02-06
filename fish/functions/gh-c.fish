function gh-c
    if test (count $argv) -eq 0
        read -p "Project name: " project
    else
        set project $argv[1]
    end

    gh repo create $project --private --clone
    or return

    cd $project
    git branch -M main
    git remote -v
end
