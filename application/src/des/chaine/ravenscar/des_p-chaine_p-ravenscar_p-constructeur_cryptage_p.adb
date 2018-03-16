with Des_P.Filtre_P.Fabrique_P.Cryptage_P;

with Des_P.Filtre_P.Corps_P.Holder_P;
with Des_P.Filtre_P.Entree_P.Holder_P;
with Des_P.Filtre_P.Sortie_P.Holder_P;

with Des_P.Faiseur_P;

package body Des_P.Chaine_P.Ravenscar_P.Constructeur_Cryptage_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Initialiser
      (
         Constructeur : in out Constructeur_Cryptage_T;
         Faiseur_56 : Faiseur_56_I_P.Constructeur_Interface_T'Class;
         Faiseur_48 : Faiseur_48_I_P.Constructeur_Interface_T'Class
      )
   is
      C : Chaine_T;
   begin
      --  Initialise une chaine vide.
      Constructeur.Chaine := C;
      Constructeur.Faiseur_56 :=
         Faiseur_56_I_P.Holder_P.To_Holder (Faiseur_56);
      Constructeur.Faiseur_48 :=
         Faiseur_48_I_P.Holder_P.To_Holder (Faiseur_48);
   end Initialiser;

   ---------------------------------------------------------------------------
   overriding
   procedure Construire
      (
         Constructeur : in out Constructeur_Cryptage_T;
         Clef : Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      )
   is
      --  La fabrique de filtre de cryptage.
      Fabrique : Des_P.Filtre_P.Fabrique_P.Cryptage_P.Fabrique_T;
      --  Les constructeurs de clef.
      Faiseur_56 : Faiseur_56_I_P.Constructeur_Interface_T'Class :=
         Constructeur.Faiseur_56.Element;
      Faiseur_48 : Faiseur_48_I_P.Constructeur_Interface_T'Class :=
         Constructeur.Faiseur_48.Element;
      --  Construction de la clef de 56.
      Clef_56 : Des_P.Clef_P.Clef_56_I_P.Clef_Interface_T'Class :=
         Des_P.Faiseur_P.Faire_Clef (Faiseur_56, Clef);
   begin
      --  Ajoute le filtre d'entrée à la chaine.
      Constructeur.Chaine.Filtre_Entree :=
         Des_P.Filtre_P.Entree_P.Holder_P.To_Holder
            (Fabrique.Fabriquer_Entree);

      --  Ajoute le filtre de corps à la chaine.
      for I in Numero_Filtre_T'Range loop
         --  Décalage à gauche pour le cryptage.
         Clef_56.Decaler_Bits_A_Gauche (Table_Decalage (I));
         --  Initialise le filtre avec la clef de 48.
         Constructeur.Chaine.Filtres_Corps (I) :=
            Des_P.Filtre_P.Corps_P.Holder_P.To_Holder
               (
                  Fabrique.Fabriquer_Corps
                  (Des_P.Faiseur_P.Faire_Clef (Faiseur_48, Clef_56))
               );
      end loop;

      --  Ajoute le filtre de sortie.
      Constructeur.Chaine.Filtre_Sortie :=
         Des_P.Filtre_P.Sortie_P.Holder_P.To_Holder
            (Fabrique.Fabriquer_Sortie);
   end Construire;

   ---------------------------------------------------------------------------
   overriding
   function Recuperer_Chaine
      (Constructeur : Constructeur_Cryptage_T)
      return Chaine_Interface_T'Class
   is
   begin
      return Constructeur.Chaine;
   end Recuperer_Chaine;

end Des_P.Chaine_P.Ravenscar_P.Constructeur_Cryptage_P;
