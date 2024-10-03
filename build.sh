#!/bin/bash

# Download PDFs from a list of URLs
# loop through the list of URLs

# Download the PDFs
for i in 6199 6389
do
    curl https://cdn.intra.42.fr/pdf/pdf/${i}/en.subject.pdf > PDFs/${i}.pdf 2> /dev/null
    cat PDFs/${i}.pdf | grep "<head><title>404 Not Found</title></head>" > /dev/null && rm PDFs/${i}.pdf
    if [ -f PDFs/${i}.pdf ]; then
        echo "Downloaded PDF ${i}.pdf"
    fi
    git remote set-url origin https://github-actions:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}
    git config --global user.name "${GITHUB_ACTOR}"
    git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"
    if (git diff --shortstat | grep '[0-9]'); then \
        git add .; \
        git commit -m "GitHub Actions Pushing"; \
        git push origin HEAD:${GITHUB_REF}; \
    fi
    # else
    #     echo "PDF ${i}.pdf does not exist"
    sleep 1
done

# curl -O https://cdn.intra.42.fr/pdf/pdf/117580/en.subject.pdf 