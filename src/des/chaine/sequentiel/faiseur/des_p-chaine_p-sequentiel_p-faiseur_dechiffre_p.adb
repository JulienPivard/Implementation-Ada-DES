with Des_P.Clef_P.Clef_56_I_P;
with Des_P.Filtre_P.Corps_P;
with Des_P.Filtre_P.Fabrique_P.Dechiffre_P;

with Des_P.Faiseur_P;

package body Des_P.Chaine_P.Sequentiel_P.Faiseur_Dechiffre_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Initialiser
      (
         Constructeur   : in out Faiseur_Dechiffrement_T;
         Faiseur_56     :        Faiseur_56_I_R.Faiseur_Interface_T'Class;
         Faiseur_48     :        Faiseur_48_I_R.Faiseur_Interface_T'Class
      )
   is
      C : Chaine_T;
   begin
      --  Initialise une chaine vide.
      Constructeur.Chaine     := C;
      Constructeur.Faiseur_56 :=
         Faiseur_56_I_R.Holder_P.To_Holder (New_Item => Faiseur_56);
      Constructeur.Faiseur_48 :=
         Faiseur_48_I_R.Holder_P.To_Holder (New_Item => Faiseur_48);
   end Initialiser;

   ---------------------------------------------------------------------------
   overriding
   procedure Construire
      (
         Constructeur : in out Faiseur_Dechiffrement_T;
         Clef         :        Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      )
   is
      --  La tète de la chaine de filtres.
      Tete        : Des_P.Etage_P.Filtrage_P.Etage_T;
      --  La fabrique de filtre de déchiffrement.
      Fabrique    : Des_P.Filtre_P.Fabrique_P.Dechiffre_P.Fabrique_T;
      --  Les constructeurs de clef.
      Faiseur_56  : Faiseur_56_I_R.Faiseur_Interface_T'Class :=
         Constructeur.Faiseur_56.Element;
      Faiseur_48  : Faiseur_48_I_R.Faiseur_Interface_T'Class :=
         Constructeur.Faiseur_48.Element;
      --  Construction de la clef de 56.
      Clef_56     : Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class :=
         Des_P.Faiseur_P.Faire_Clef
            (
               Faiseur => Faiseur_56,
               Clef    => Clef
            );
   begin
      --  Ajoute à la tète le filtre d'entrée.
      Tete.Modifier_Filtre (Filtre => Fabrique.Fabriquer_Entree);

      --  Ajoute le filtre de corps à chaque filtre.
      for I in reverse Numero_Filtre_T loop
         Initialisation_Filtre :
         declare
            E : Des_P.Etage_P.Filtrage_P.Etage_T;
            --  Initialise le filtre avec la clef de 48
            --  qui lui est spécifique.
            F : constant Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class :=
               Fabrique.Fabriquer_Corps
                  (
                     Clef => Des_P.Faiseur_P.Faire_Clef
                        (
                           Faiseur => Faiseur_48,
                           Clef    => Clef_56
                        )
                  );
         begin
            E.Modifier_Filtre (Filtre => F);
            --  Ajoute l'étage à la fin de la chaine.
            Tete.Ajouter_Successeur (Successeur => E);
         end Initialisation_Filtre;
         --  Décalage à gauche pour le déchiffrement.
         Clef_56.Decaler_Bits_A_Droite (Nb_Decalage => Table_Decalage (I));
      end loop;

      --  Ajoute le filtre de sortie au dernier étage.
      Lier_Filtre_Et_Etage_Sortie :
      declare
         Etage : Des_P.Etage_P.Filtrage_P.Etage_T;
      begin
         Etage.Modifier_Filtre (Filtre => Fabrique.Fabriquer_Sortie);
         Tete.Ajouter_Successeur (Successeur => Etage);
      end Lier_Filtre_Et_Etage_Sortie;

      --  Change la tète de la chaine.
      Constructeur.Chaine.Tete := Tete;
   end Construire;

   ---------------------------------------------------------------------------
   overriding
   function Recuperer_Chaine
      (Constructeur : Faiseur_Dechiffrement_T)
      return Chaine_Interface_T'Class
   is
   begin
      return Constructeur.Chaine;
   end Recuperer_Chaine;

end Des_P.Chaine_P.Sequentiel_P.Faiseur_Dechiffre_P;
