with Des_P.Filtre_P.Fabrique_P.Dechiffre_P;
with Des_P.Clef_P.Clef_56_I_P;

with Des_P.Filtre_P.Corps_P.Holder_P;
with Des_P.Filtre_P.Entree_P.Holder_P;
with Des_P.Filtre_P.Sortie_P.Holder_P;

with Des_P.Faiseur_P;

package body Des_P.Chaine_P.Ravenscar_P.Faiseur_Dechiffre_P is

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
      Constructeur.Chaine := C;
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
      --  La fabrique de filtre de chiffrement.
      Fabrique : Des_P.Filtre_P.Fabrique_P.Dechiffre_P.Fabrique_T;
      --  Les constructeurs de clef.
      Faiseur_56 : Faiseur_56_I_R.Faiseur_Interface_T'Class :=
         Constructeur.Faiseur_56.Element;
      Faiseur_48 : Faiseur_48_I_R.Faiseur_Interface_T'Class :=
         Constructeur.Faiseur_48.Element;
      --  Construction de la clef de 56.
      Clef_56 : Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class :=
         Des_P.Faiseur_P.Faire_Clef
            (
               Faiseur => Faiseur_56,
               Clef    => Clef
            );
      --  Le décalage est inversé donc il faut deux compteurs.
      J : Numero_Filtre_T := Numero_Filtre_T'First;
   begin
      --  Initialise le lecteur de fichier.
      Lecteur := Lecteur_Fichier'Access;
      --  Initialise l'écriveur de fichier.
      Ecriveur := Ecriveur_Fichier'Access;

      --  Ajoute le filtre d'entrée à la chaine.
      Constructeur.Chaine.Filtre_Entree :=
         Des_P.Filtre_P.Entree_P.Holder_P.To_Holder
            (New_Item => Fabrique.Fabriquer_Entree);

      for I in reverse Numero_Filtre_T loop
         --  Initialise le filtre J avec la clef de 48 I.
         Constructeur.Chaine.Filtres_Corps (J) :=
            Des_P.Filtre_P.Corps_P.Holder_P.To_Holder
               (
                  New_Item => Fabrique.Fabriquer_Corps
                  (
                     Clef => Des_P.Faiseur_P.Faire_Clef
                        (
                           Faiseur => Faiseur_48,
                           Clef    => Clef_56
                        )
                  )
               );
         --  Décalage à gauche pour le déchiffrement.
         Clef_56.Decaler_Bits_A_Droite (Nb_Decalage => Table_Decalage (I));
         --  Incrémentation de la position dans le tableau de filtre de corps.
         if J /= Numero_Filtre_T'Last then
            J := Numero_Filtre_T'Succ (J);
         end if;
      end loop;

      --  Ajoute le filtre de sortie.
      Constructeur.Chaine.Filtre_Sortie :=
         Des_P.Filtre_P.Sortie_P.Holder_P.To_Holder
            (New_Item => Fabrique.Fabriquer_Sortie);
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

end Des_P.Chaine_P.Ravenscar_P.Faiseur_Dechiffre_P;
