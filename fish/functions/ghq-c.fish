function ghq-c --description "Create a ghq directory and a GitHub repo, then cd into it and add the origin remote"
    if test (count $argv) -eq 0
        echo "project name was not found"
        return 1
    end

    set -l git_username (git config --get user.name); or return 1
    set -l ghq_root (ghq root); or return 1
    set -l repository github.com/$git_username/$project
    set -l ghq_dir $ghq_root/$repository
    set -l project $argv[1]

    ghq create $project
    or return 1
    gh repo create $argv
    or begin
        rm -rf $ghq_dir
        return 1
    end

    cd $ghq_dir
    git remote add origin https://$reposityory.git
end
