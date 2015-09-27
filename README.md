# oracledba.net


http://lea.verou.me/2011/10/easily-keep-gh-pages-in-sync-with-master/

Now, when I use gh-pages, there are only a few more commands that I have to use after the above:

    git checkout gh-pages // go to the gh-pages branch
    git rebase master // bring gh-pages up to date with master
    git push origin gh-pages // commit the changes
    git checkout master // return to the master branch



RUN Oracle DBA by Jekyll

    $ jekyll serve --watch  --host 0.0.0.0 --port 8080
