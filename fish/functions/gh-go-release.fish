function gh-go-release
    if test (count $argv) -eq 0
        read -p "Version: " gh_release_version
    else
        set gh_release_version $argv[1]
    end

    set gh_release_version (string replace -r '^v' '' $gh_release_version)
    
    gh release create v$gh_release_version --title "v$gh_release_version" --generate-notes
end
