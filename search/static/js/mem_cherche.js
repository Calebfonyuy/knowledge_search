function rech_associe()
{
	//var chaine='|absolues excel|acces|access|access sql|access vba|analyse excel|application|automatise|automatiser|base access|base de donne|base de donnee|base de donnees|base de donnes|bases de donnees excel|boucle excel|boucles excel|calcul|client|clients|code vba|condition excel|date|dates vba|deroulant|deroulante|didacticiel|doublon|doublon vba|doublons excel|dynamique|enregistre|excel et vba|excel vba|extraction de donnee|extraire des donnees excel|extraire excel|extraire les donnees|facturation|facture|factures|fichier|figer|figer excel|filtre excel|filtrer et|filtres|fonction if|fonction nb|fonction si|fonctions excel|format conditionnel|format dynamique|formats excel|forme|formulaire|formulaire acces|formulaire access|formulaires access|gestion rh|graphe|graphique excel|graphiques excel|index|jeu excel|la fonction si|la recherche v|les graphiques|les raccourcis du clavier|lier|ligne|liste deroulant|liste deroulante access|liste deroulante excel|liste deroulantes|listes deroulantes dynamiques|macro excel|macros access|macros excel|mise en forme automatique|mise en forme conditionnel|mise en forme conditionnelle|mise en forme sous condition|mise en forme word|mise en page|mot cle access|multi|paragraphes word|photo shop|photos|power point|prime si anc|primes|programmation excel|raccourci clavier|recherche et extraire|recherche excel|recherche vba|recherchev excel|reference absolue|references absolues excel|requete access|requetes access|requetes sql|saisie|script|selection vba|si ou|somme si|source|sources s vba|sous formulaire access|stock|stock bl|table|tableau excel|tableau vba|tableaux|tables access|tri des donnees|tva access|vba access|vba excel|vba set|visual basic';

	document.getElementById("prop").innerHTML="";
	var saisie = $('#search-text0').val();
	var nbCar = saisie.length;

	if(nbCar>0){
		$.ajax({
			url: '/words',
			method: "GET",
			data: {
				word: saisie,
				lang: $('select[name=language]').val()
			},
			success: function(data){
				affiche(data);
				console.log(data);
			},
			error: function(data){
				console.log(data.responseText)
			}		
		})
	}else{
		document.getElementById("prop").style.visibility="hidden";
	}
	return ;
}

//afficher les recherches associées
function affiche(chaine){
	if(chaine!=[]){
		document.getElementById("prop").style.visibility="visible";
		let html =''
		for(let i=0;i<chaine.length;i++){
			html += "<div class='flux' onClick='choix(\"" + chaine[i] + "\")'>"+chaine[i] + "</div>"; 
		}
		$('#prop').html(html);
	}
	if(chaine==[]){
		document.getElementById("prop").style.visibility="hidden";
	}
}



