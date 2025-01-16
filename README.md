# Application : Open Air Point of Sale

## 📁 Présentation des Principaux Dossiers

 Dossier        | Description                                                                                   
----------------|-----------------------------------------------------------------------------------------------
 **doc**        | Contient la documentation relative aux points techniques de l'application             
 **assets**     | Contient les différentes images et icônes de l'application ainsi que les polices d'écriture 
 **comm**       | Contient la logique de communication et l'élaboration des packets échangés entre les différents appareils                    
 **model**      | Contient la logique métier de l'application                                             
 **repository** | Contient la logique d'accès et de modification de la base de données (CRUD) 
 **view_model** | Contient la logique de liaison entre la logique métier et l'interface utilisateur. Permet une gestion claire des responsabilités selon le pattern MVVM                                 
 **screens**    | Contient les différents écrans de présentation de l'application. Un regroupement des écrans est fait pour les parties d'administation, et de service (barman et serveur)         
 **theme**      | Contient les éléments de styles et de couleurs                                            
 **widgets**    | Contient les widgets réutilisables sur différents écrans                                


## 🚀 Présentation de l'Application

L'application 'OpenAir Point Of Sale' permet la prise de commande dans des conditions qui ne permettent pas d'avoir un accès facile à internet. 
Elle fonctionne donc en créant un réseau fermé à petite/moyenne échelle. Cette application vise plus particulièrement les créateurs d'évennements en plein air (festivals, tournoi sportifs, brocante, ...)

L'application se concentre sur trois rôles :

1. **L'administrateur** s'occupe de la gestion des évenemments. La partie de l'application qui lui est dédié lui permet (ou permettra selon l'avancement de l'implémentation) :
- La création d'évennements. Un évennement est défini par son nom, le lieu ainsi que par la date à laquelle celui-ci se déroule
- La gestion du personnel utilisant l'application. Les utilisateurs ayant chacun un ou plusieurs rôles qui leur sont défini en fonction de leur implication dans l'évennement. 
Ils sont assigné à un évennement pour pouvoir y prendre part et s'y joignent en s'authentifiant sur l'application
- La gestions des cartes qui permet de définir différents menu via l'ajout ou la suppression de produits (boissons, nourriture). Ces menus peuvent ensuite être assignés à un évennement
- La gestion de données sur ses évennements passés, en cours ou à venir

2. **Le serveur** qui prend les commandes des clients et les envoies vers le bar
3. **Le barman** qui prépare les commandes et notifie le serveur quand celle-ci est prête

## 🌐 Étude de l'Existant

Les applications de type "point de vente" existantes sont majoritairement conçues pour des commerçants ayant une caisse enregistreuse fixe, connectée à internet via Wi-Fi ou 4G/5G. Ces solutions sont adaptées à des environnements stables, où la connectivité est garantie. Cependant, elles présentent des limites importantes dans des contextes nécessitant mobilité ou opérant dans des zones avec une connectivité internet faible ou inexistante.

Notre application cherche donc à ce démarquer sur ces différents points. 

Nous proposons une application permettant rapidité et mobilité en ayant d'une part le serveur au plus prêt du client et d'autre part le barman recevant la commande dès que celle-ci a été formulée.

Contrairement aux solutions traditionnelles, notre application fonctionne dans un circuit fermé, permettant la communication entre appareils sans dépendre d'une connexion internet externe.

## 🎯 Public Cible

En favorisant une infrastructure légère et flexible, nous désirons offrir une solution idéale pour les événements en extérieur tels que des festivals, où la rapidité d'exécution et la fiabilité sont essentielles.

## 📋 Fonctionnalités

Voici les différents story points permettant de décrire les fonctionnalités implémentées ou à implémenter.
Dans l'état actuel de l'application, l'encaissement est considéré à charge du serveur, mais cela pourra évoluer.

En tant que responsable d’évènement :
- pouvoir créer un nouvel évènement
- pouvoir chercher, gérer et visualiser un évennement en particulier
- avoir un aperçu de l'ensemble mes évènements passés, présent et à venir
- pouvoir archiver un évennement passé
- pouvoir exporter les données d’un ou plusieurs évennements
- visualiser les statistiques de mes évennnements (avec ou sans filtres)
- pouvoir créer et chercher des cartes (boissons, nourriture, …) réutilisables dans différents évennements
- pouvoir définir les rôles (et accès) du personnel sur l'application

En tant que serveur, je désire :
- pouvoir prendre des commandes
- pouvoir visualiser un commande
- pouvoir encaisser une commande en espèce ou en monnaie d’évènement
- pouvoir encaisser une commande par payement bancaire
- pouvoir imprimer mes tickets

En tant que barman, je désire : 
- pouvoir recevoir une commande
- pouvoir confirmer la préparation une commande

En tant qu’utilisateur de l’application, je désire :
- pouvoir m’authentifier sur l’application
- pouvoir gérer les notifications que je reçois de l'application


## 📈 État d'Avancement

### Identification
L'utilisateur entre son nom et son prénom. Cette interface permet d'identifier l'utilisateur et de créer un identifiant lié à celui-ci. 
Le but étant, dans un futur proche, d'utiliser ces informations pour permettra l'accès à l'application de manière sécurisée et également d'identifier, dans les données d'évennement, les commandes effectuées par cette personne.

L'identifiant et le nom de la personne sont ensuite affichés en haut des écrans 'home' des différents rôles. De cette manière, si plusieurs personnes utilisent le même appareil, il est possible de s'assurer être le bon utilisateur. 

![Alt Text](https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExNndleDJzMHN5dmRoYXFodDJnc3ducXpiMDd1d29sb3pucGUwY3c0ZSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Uzya8nRMGreRVqQ8kc/giphy.gif)

### Sélection de rôle
Dans l'état actuel de l'application, tous les rôles sont accessibles. 
Mais cela ne sera plus le cas dès la mise en place de l'authentification, permettant ainsi l'accès de chaque rôles aux utilisateurs appropriés.
Les rôles actuellement implémentés sont les suivants :
- Administrateur d'évennement
- Serveur
- Barman

Pour la description des rôles, aller voir le point 'présentation de l'application' plus haut dans ce document.

![Alt Text](https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExc2xlN3htZjIxbXFidWx6cWphejZpaHM1bHMxdGV3bnRjMnZyaDM4aSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/72kadRF5RTd4X8gwD6/giphy.gif)

### Sélection de connexion
Dans l'état actuel de l'application, un appareil est considéré comme root dès l'accès à l'écran 'bartender'. Le barman étant central dans l'organisation liée à l'application,
celui-ci est totallement approprié à endosser ce rôle. 
Nous considérons donc actuellement l'utilisation d'un seul appareil pour la réception des commandes, mais cela pourra évoluer par la suite.

Le barman, après avoir sélectionner son rôle va quant à lui sélectionner l'appareil root auquel se connecter. 
Cette demande de connexion nécessite une approbation du root, sans quoi la connexion échoue. La connexion en question permet l'envoi et la réception de commandes entre les différents intervenants.

![Alt Text](https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZXNmc3NjZDRzcjlzYjNnbjBxbWNzcHNvZ3M2dWpkbWhoZjV4cGpsOSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/JSez8yNmTywO04FfR2/giphy.gif)

### Création de produits
Un administrateur à la possibilité de créer les différents produits qui seront ensuite assignés aux menus. 
Actuellement, les données à fournir pour un produit sont :
- Son nom
- Son prix
- La catégorie auquel ce produit appartient

![Alt Text](https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExNGtxaXZhb3psbzVwOW82bHA0MzYyN3AwanV6d2g5NWFwam5kb3BiaSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/gnZyHVIGabPesjl4iq/giphy.gif)

### Création de menu
Un administrateur crée un menu à partir de plusieurs produits et assigne un nom à ce menu pour pouvoir l'identifier. 
Actuellement, l'affichage de l'écran de gestion est très épuré et n'affiche que le nom du menu et le nombre de produit qu'il contient. 
Le but étant, dans un futur proche, de pouvoir gérer le contenu des différents menus depuis l'écran de gestion concerné.
La fonction de recherche nécessite également d'être implémentée pour pouvoir trouver plus rapidement un menu en fonction de son nom.

![Alt Text](https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExaXNvdW5vN3lvMHgyaDVjeTJsMTVubzdnaDVxdWQ4MGZ1YmUwNHp6eCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/qEJlkCnqKHnWin0nkw/giphy.gif)

### Création de commande
Un serveur crée un commande à partir des produits disponibles. Actuellement, il s'agit de l'ensemble des produits et non ceux d'un menu. 
Cela sera implémenté avec la gestion d'évennement, un menu étant lié à un évennement.
Après avoir sélectionné les produits de la commande, le serveurs peut ajuster la quantité de chacun de ces produits. 
Le prix de la commande en sera impacté immédiatemment.
Chaque commande peut recevoir un tag, permettant de l'identifier le plus facilement et rapidement possible. 
Si aucun tag n'est appliqué, la commande sera nommée en fonction de son numéro d'ordre.

![Alt Text](https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExbzhpbzAxOXR0OG15bHdzazFoaG85NHp4YWs5bThsOHcxaXRwMm8zbSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/e9IkftcsiWL0TJwWNG/giphy.gif)

### Envoi et réception de commande
Dès que la commande est terminée, le serveur valide celle-ci en l'envoyant vers le bar. 
Celle-ci s'affiche donc dans la liste des commandes à traiter chez le concerné.
Il est prévu, par la suite, d'ajouter une fenêtre de validation pour s'assurer de ne pas envoyer la commande par erreur.
Cette fenêtre de validation sera paramétrable (affichable ou non) selon les préférences de l'utilisateur.

![Alt Text](https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZWF1MHNyMmZ2Ynhqamlvajkxbm42OTR1Nnc4ZGthNjVnZGhjcnJnMSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/AROU54ZzRFUxCXQi0m/giphy.gif)

### Apercu d'une commande
Le barman après réception, peut sélectionner une commande et en afficher le contenu. La validation de préparation n'est pas encore implémentée.

![Alt Text](https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExYjJsNzY1MHY0a2NrZDFrbXRjNnQ1azA1ZGQyYmxqMWxpazQzZDVhaSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/yqM1yLsYGHPt0MsGxu/giphy.gif)

### Apercu d'interface d'administration
L'écran d'administration contient :
- Une liste défilante fournissant un apercu des derniers évennement créés (et une barre de recherche)
- Un accès rapide pour la création d'un nouvel évennement
- Un accès à un écran de gestion d'évennements
- Un accès à un écran de gestion des utilisateurs
- Un accès à un écran de gestion des menus et produits
- Un accès à un écran permettant le visionnage des statistiques et l'export de données

Actuellement, seule la gestion des menus est opérationnel.
Il est prévu de pouvoir organiser l'affichage de la liste d'évennements en fonction des préférences de l'utilisateur : en fonction de la date, n'afficher que les évennements passés ou futur, ...

![Alt Text](https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExM2MyaG53c2xmdG41cXkxYjJqY3U3c2owMHk0bjcyaGM5eXBsaWpnZiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/iKkO5FQNBFVNoMZwl6/giphy.gif)


## Limitations

L'application se limite malheuresement aux appareils Android, restriction due à l'implémentation du plugin **flutter_p2p_connection**. De plus celui-ci se repose sur le WiFi-Direct.
La technologie WiFi-Direct peut ne pas être implémentée sur un appareil, il est donc vivement conseillé de vérifier la compatibilité de la puce WiFi de l'appareil installé par le constructeur.  
Pour la vérification, on peut compter sur la [WiFi Alliance](https://www.wi-fi.org/discover-wi-fi/wi-fi-direct).
Plus d'information à l'adresse suivante : [https://www.wi-fi.org/product-finder-results?sort_by=certified&sort_order=desc&certifications=900](https://www.wi-fi.org/product-finder-results?sort_by=certified&sort_order=desc&certifications=900).

<!-- vim: set spelllang=fr :-->
