function git-wt-del --description "Delete a branch and worktree that created by git-wt"
    if test (count $argv) -eq 0
        echo "please enter the branch name"
        return 1
    end

    set -l branch $argv[1]
    set -l git_wt_base (git config --get wt.basedir); or return 1

    git-wt -d $branch
    or return 1
    
    rm -rf $git_wt_base/$branch
    or return 1

    git push origin --delete $branch
end
