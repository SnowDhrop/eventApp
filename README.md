# eventApp

An App which propose the events that are related to your interests

# ENV procedure

- On crée une branche pour chaque nouvelle feature
- Lorsqu'elle est terminée on la push sur back ou front
- On push de temps en temps le back/front (lorsque tout est ok) sur dev et on récupère le front/back du dev
- On push de temps en temps le dev sur la prod si pas de bugs

# Git procedure

- checkout branche feature
- add . > commit > push
- git push origin [branch with new changes] : [branch your are pushing to]

- git checkout front > git pull (récupérer changements distant)
- git push origin [branch with new changes] : [branch your are pushing to]
- ... jusqu'à prod

# Scripts

- npm run seed: create initial datas for categories/styles/artists
- npm run dropTables: delete all tables. The tables are recreated when you start again the server. Don't forget to do add initial datas with "npm run seed"
