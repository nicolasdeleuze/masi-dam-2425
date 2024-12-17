# Mon Application

> Vous vous adressez potentiellement à un futur employeur et donc une personne qui n'aura pas nécessairement l'occasion de compiler votre projet. Votre `README.md` contiendra donc au moins :

## 📁 Présentation des Principaux Dossiers

> Une présentation des principaux dossiers de votre dépôt. Quelles sont les différentes ressources qu'il contient à la racine ? Par exemple, les maquettes, vos inspirations, etc. Si vous avez fait des efforts quant à l'organisation de vos fichiers dans le dossier `lib`, expliquez-les ici.
Les principaux dossiers du projets sont actuellement les suivants :
- comm : contient la logique de communication entre les différents appareil
- model : contient la logique métier de l'application
- screens : contient les différents écrans de présentation de l'app
- theme : contient les éléments de styles et de couleurs
- widgets : contient les widgets réapplicable sur différents écrans

## 🚀 Présentation de l'Application

> Une présentation de votre application. Ce dernier répond à un besoin, présentez-le. Ne faites aucune hypothèse sur le niveau de connaissances de votre lecteur. Vous vous adressez ici à un internaute quelconque qui découvre votre dépôt. Évitez un jargon technique dans cette partie de votre présentation.
L'application 'OpenAir Point Of Sale' permet la prise de commande dans des conditions ne permettant pas d'avoir un accès facile à internet. Elle fonctionne donc en créant un réseau fermé à petite/moyenne échelle. Cette application vise plus particulièrement les créateurs d'évennements en plein air (festivals, tournoi sportifs, brocante, ...)
L'application tourne autour de trois rôles principaux :
- L'administrateur qui s'occupe de la gestion des évenemments. Il crée un évennement, y affecte du personnel et ajoute une carte de produits.
- Le serveur qui prend les commandes des clients et les envoies vers le bar
- Le bar qui prépare les commandes et notifie le serveur quand celle-ci est prête

## 🌐 Étude de l'Existant

> Une brève étude de l'existant. L'idée étant de savoir si d'autres ont déjà couvert le besoin auquel vous essayez de répondre. Ce qui est demandé ici, au-delà d'une brève description, ce sont les points forts et les points faibles de ces différentes applications. Il peut être intéressant de faire un tableau pour mettre en regard les avantages et les inconvénients. Enfin, mettez des captures d'écran des applications afin que l'on comprenne mieux de quoi on parle.

## 🎯 Public Cible

> Parlez de votre public cible. À qui s'adresse votre application et surtout comment prenez-vous en compte ce public-là ?

## 📋 Fonctionnalités

> Une présentation des différentes fonctionnalités de votre application au travers de récits utilisateurs (user story). Soit une description courte et simple d’un besoin ou d’une attente exprimée par un utilisateur. Chacun de ces récits suit la syntaxe "En tant que **&lt;qui&gt;**, je veux **&lt;quoi&gt;** afin de **&lt;pourquoi&gt;**":

> Le **qui** indique le rôle/statut de l’utilisateur à ce moment-là. Par exemple "membre premium" ou "utilisateur non identifié". Pour mieux illustrer la diversité des besoins, on peut également utiliser le concept de persona, c'est-à-dire une personne fictive et représentative à laquelle on peut s'identifier pour mieux comprendre ses attentes. L'identification et la description des personas se fait alors avant de commencer l'écriture des récits utilisateurs. Par exemple, "Odile est une enseignante qui utilise pour la première fois le système".

> Le **quoi** décrit succinctement la fonctionnalité ou le comportement attendu. Le but du récit n'est pas d'en fournir une explication exhaustive.

> Le **pourquoi** permet d'identifier l'intérêt de la fonctionnalité et d'en justifier le développement. Il permet également de mieux évaluer la priorité des fonctionnalités. Pour chacune de ces fonctionnalités, présentées par un récit utilisateur, vous présenterez les maquettes qui s'y rapportent.

## 📈 État d'Avancement

>  Un état d'avancement pour chaque fonctionnalité de votre application. Ceci doit évidemment être mis à jour régulièrement. Dès lors que vous aurez terminé de programmer une fonctionnalité, ajoutez dans le document `README.md` un `.gif` qui l'illustre. Vous pouvez vous servir de [GIF Brewery](https://apps.apple.com/us/app/gif-brewery-3-by-gfycat/id1081413713?mt=12) (Si vous êtes sous macOS) ou de [Gyazo](https://gyazo.com) (Si vous êtes sous Windows).

### Interface utilisateur

Aucune connexion n'est actuellement faite avec le backend

- L'utilisateur peut sélectionner le rôle qu'il désire prendre dans l'organisation de l'évennement(Cela sera par la suite modifié afin de protéger les rôles essentiels de toutes mauvaises manipulations)
- Le serveur peut voir une liste de commandes contenant le numéro de la commande, le prix ainsi que le statut de celle-ci.

### Communication

La communication root (barman) <-> clients (serveurs) avance principalement par essai erreurs.
Le root ouvre actuellement un réseau Wifi Direct (vérification à l'aide d'un autre appareil).
Côté du client, nous observons via la console de debug que celui-ci voit le root. Actuellement nous essayons d'utiliser la librairie *Provider* dans le but de mettre à jour l'UI à partir du backend.

## ⚙️ Compilation de l'Application

> Enfin, nous vous demandons d'ajouter une section pour les développeurs où vous expliquez ce qu'il faut faire pour pouvoir compiler l'application. Cette documentation doit être simple et surtout efficace.

<!-- vim: set spelllang=fr :-->
