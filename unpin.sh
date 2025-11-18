gsettings set org.cinnamon favorite-apps "$( \
    gsettings get org.cinnamon favorite-apps | \
    tr -d "[]'" | tr ',' '\n' | \
    grep -v '^terminal\.desktop$' | \
    awk '{printf "\"%s\",",$0}' | sed 's/,$//'; \
    echo )"
