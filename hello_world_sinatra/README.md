
## Sinatra

Tu vas faire ton premier site en Ruby, en explorant Sinatra, un framework qui permet de faire du web. Le framework est assez bas-niveau, c'est à dire que tu devras presque tout coder toi-même. Là où Rails est plus haut-niveau, et qu'il fera tout le taf pour toi.

## 1. Introduction

Dans cette ressource, nous allons te montrer comment travailler avec Sinatra, un framework Ruby conçu pour coder des applications web. C'est un framework plus bas-niveau que Ruby on Rails (= une ligne de Rails = 3 lignes en Sinatra) et c'est parfait au début pour comprendre les rouages d'une application web. Par contre on ne l'utilisera pas longtemps car Sinatra te fait réinventer la roue.

Sinatra se présente tout simplement sous la forme d'une gem (tout comme Rails).

Objectif de la journée : te présenter les grands concepts qui vont t'accompagner tout au long de ton apprentissage de Rails. Cela inclus l'utilisation d'un serveur local, l'archi MVC, les routes, les views, les BDD, l'utilisation de formulaires, etc.

Allez Sinatra, Fly me to the moon 🚀 !

## 2. Historique et contexte

Sinatra est une bibliothèque Ruby open source qui permet de faire des applications web. Elle a été créée en 2007 (donc deux ans après Rails) par un certain Blake Mizerany dans le but de créer des applications, en mode ultra minimal, sans effort. Sinatra ne suit pas le modèle MVC : il laisse les utilisateurs faire un choix d'architecture logicielle web.

Et sinon : "oui". Sinatra est nommée ainsi à cause de Frank Sinatra 🎤 ☔

## 3. La ressource

On va construire ensemble une application ultra basique qui te permettra de découvrir le fonctionnement de Sinatra.

Une grosse fonctionnalité de Sinatra est de **pouvoir lancer un serveur local (sur ton ordi) en Ruby**. Le rôle d'un serveur c'est, grosso modo, de recevoir des requêtes HTTP et de retourner en réponse des fichiers (HTML, CSS, JS, etc.). Par exemple si tu vas sur [https://www.facebook.com/](https://www.facebook.com/), le serveur de Facebook va faire "Hé j'ai reçu une requête de type GET sur ma page portant l'URL '/'. Je vais donc renvoyer le code HTML et CSS qui correspond !". Et là il va te balancer ce qu'il faut pour afficher la page d'accueil de Facebook.

Pour ton info, sache que sur le web, certaines requêtes peuvent donner lieu à l'envoi d'autres formats que des fichiers HTML ou CSS. Par exemple si tu vas sur [ce lien](http://www.omdbapi.com/?t=pulp+fiction&apikey=5c030292), tu vas voir dans le code source que le site t'a renvoyé un JSON.

Bref, quand tu vas sur facebook.com, une page s'affiche sur ton navigateur web, car ce dernier sait interpréter les fichiers HTML/CSS obtenus. Si le site est statique (un blog de base par exemple), chaque visiteur reçoit les mêmes fichiers HTML/CSS (les mêmes articles du blog). Par contre si le site est dynamique, comme Facebook, la page affichée pour toi (qui est connecté à ton compte) sera différente de la mienne (si je suis connecté), ou de celle d'une personne non connectée. Par exemple on aura chacun une page profil différente et un newsfeed différent. C'est parce que les serveurs de Facebook génèrent leurs réponses HTML / CSS de manière dynamique et en fonction de l'utilisateur qui navigue sur le site.

Avec Sinatra, tu vas pouvoir faire de même et générer des sites web dynamiques où la réponse HTML / CSS dépendra du code que tu vas écrire ! Allez, on se lance dans notre premier site web.

### 3.1. Version de Ruby

#### 3.1.1. RVM

N'oublie pas que durant l'installfest, nous t'avons demandé d'installer RVM, Ruby Version Manager, celui-ci te permet de passer d'une version ruby à une autre sans trop d'efforts à fournir !

#### 3.1.2. Changement de Version

Pour ce projet il te faudra utiliser une ancienne version de ruby, la 2.7.4 suffira, pas de panique, juste 2 commandes et le souci est réglé.

-   `rvm install 2.7.4`
-   `rvm use 2.7.4`

Et voilà, tu es sous la bonne version pour faire ce projet !

#### 3.1.3. Version par défaut

N'oublie pas de changer de version une fois le projet terminé, tu peux également passer la version que tu utilises le plus souvent en version par défaut, comme ceci :

-   `rvm use --default 3.0.0`
-   `rvm list` te permet de voir toutes tes versions de ruby

### 3.2. Hello World !

Tu vas lancer ton premier serveur et il aura pour rôle de faire une réponse statique : un message simple. Commence par créer un dossier `hello_world_sinatra` qui contiendra deux fichiers : un `Gemfile` et un fichier `app.rb`.

#### Gemfile

Le Gemfile va contenir notre version de Ruby habituelle, ainsi que `gem 'sinatra'`. Je te laisse faire le `bundle install`. Si cela ne fonctionne pas, tu peux ajouter Sinatra au préalable avec la commande `gem install sinatra`.

#### app.rb

Voici ce que va contenir le fichier `app.rb` :

```ruby
require 'sinatra'

get '/hello' do
  '<h1>Hello world ! </h1>'
end
```

#### C'est prêt !

On t'avait prévenu : Sinatra c'est tout basique. 🤓

Pour tester ton programme, tu n'as qu'à exécuter ton programme `$ ruby app.rb`. Le terminal va balancer un message du style :

```shell
== Sinatra (v2.0.4) has taken the stage on 4567 for development with backup from Puma
Puma starting in single mode…
* Version 3.6.5 (ruby 2.7.4-p0), codename: Llamas in Pajamas
* Min threads: 0, max threads: 16
* Environment: development
* Listening on tcp://localhost:4567
Use Ctrl-C to stop
```

Prends le temps de le lire 2 secondes. En gros, ce qu'il faut comprendre c'est qu'il te dit "j'ai lancé Puma (un serveur), c'est cool", il t'informe qu'il écoute d'éventuelles requêtes HTTP sur le port `localhost:4567`, et que tu peux arrêter le serveur en faisant `Ctrl-C` (ne fais pas ça pour le moment).  
  
On va aller voir ce que le serveur Puma nous répond si on va sur [http://localhost:4567/hello](http://localhost:4567/hello) avec notre navigateur. Et là, SURPRISE, il t'affiche un gros "Hello world !" et si tu regardes le code source de la page, tu verras qu'il correspond exactement à `app.rb` et son code : `<h1>Hello world ! </h1>`.

### 3.3. Que s'est-il passé ?

C'est la magie de Sinatra : dès que tu l'exécutes, il lance un serveur qui va réagir en fonction du code que tu as écrit. Ainsi le serveur va tourner en local (sur ton ordi), et s'il voit passer une requête sur le port où il est en écoute (localhost:4567 dans notre cas), il exécute le code correspondant à cette requête et produit un fichier HTML en fonction. Là, notre code lui dit "si quelqu'un va à l'adresse `/hello` en GET, renvoie-lui ce code HTML : `<h1>Hello world ! </h1>`".

##### 3.3.1. C'est quoi un GET ?

Il existe **plusieurs types de requêtes HTTP**, et nous allons en voir deux aujourd'hui : GET et POST.

Quand tu saisis l'adresse "[www.facebook.com](http://www.facebook.com/)" dans ton navigateur web, en fait tu lui demandes de faire une requête GET sur cette URL. Cette requête GET va arriver au serveur de Facebook qui va l'interpréter comme si tu lui disais : "Peux-tu m'envoyer le contenu correspondant à [www.facebook.com](http://www.facebook.com/) ?". Ce qu'il va faire avec plaisir

La requête POST, elle, est un peu plus complète. Un bon exemple serait quand tu te login sur facebook.com : en faisant ça, tu envoies plus qu'une simple URL. En effet, pour te connecter à ton compte, tu soumets un formulaire avec de l'info dedans : ton e-mail et ton mot de passe. Dans ce cas, c'est un POST où tu dis au serveur de Facebook : "voici les informations demandées (login + mot de passe), maintenant traite-les et balance-moi du contenu en retour".

Pour faire simple, une requête GET c'est juste demander d'afficher le contenu d'une URL donnée. Une requête POST c'est envoyer le contenu d'un formulaire et obtenir une réponse en retour.  
  
Pour schématiser, GET pourrait correspondre à `puts` et POST pourrait correspondre à un `gets.chomp` suivi d'un `puts`.

Pour notre exemple, si j'avais mis dans le code `post '/hello' do --- end` , cela voulait dire que si quelqu'un complétait un formulaire sur la page `/hello`, Sinatra aurait exécuté le code entre `do` et `end`. Et non plus la partie en `get '/hello'`.

##### 3.3.2. Les routes

Les routes sont les URL qui vont entraîner une réponse du serveur et donc une action. En écrivant `get '/hello' do ---- end`, tu as mis une route sur le GET de `/hello`. Cela indique au serveur : "si quelqu'un va sur `/hello`, voilà le code à exécuter".

Par contre, si tu vas sur une URL non prévue (exemple : [http://localhost:4567/bonjour](http://localhost:4567/bonjour)), Sinatra va te renvoyer une page HTML qui dit "hé, y'a pas de route à cette adresse-là". En gros, comme tu ne lui as pas expliqué quoi faire si quelqu'un va sur `/bonjour`, il est perdu et renvoie une erreur.

Maintenant on va s'amuser à paramétrer cette route `/bonjour` qui était jusque-là inconnue. Ajoute dans ton fichier `app.rb` le code suivant :

```ruby
get '/bonjour' do
  '<h1>Bonjour, monde !</h1>'
end
```

Pour que cette nouvelle route soit prise en compte, il faut que tu coupes le serveur (CTRL-C) et relances `$ ruby app.rb`. Maintenant, retourne sur [http://localhost:4567/bonjour](http://localhost:4567/bonjour) : Sinatra sait quoi faire et va t'afficher "Bonjour, monde !".

## 4. Pour aller plus loin

Bon, un programme statique qui affiche "Hello world !", c'est un peu limité. Ce que nous allons faire ensuite, c'est utiliser ces bases pour faire une application dynamique, qui interagit avec l'utilisateur. Nous allons ranger le programme dans un beau dossier bien ordonné et faire des requêtes POST qui traiteront de l'information.

Voici [la doc de la gem Sinatra](http://sinatrarb.com/intro.html), que tu peux survoler si le cœur t'en dit.