with Des_P.Clef_P.Clef_56_I_P;
with Des_P.Filtre_P.Corps_P;
with Des_P.Filtre_P.Fabrique_P.Cryptage_P;

with Des_P.Faiseur_P;

package body Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P is

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
      --  La tète de la chaine de filtres.
      Tete : Des_P.Etage_P.Filtrage_P.Etage_T;
      --  La fabrique de filtre de chiffrement.
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
      --  Ajoute à la tète le filtre d'entrée.
      Tete.Modifier_Filtre (Fabrique.Fabriquer_Entree);

      --  Ajoute le filtre de corps à chaque filtre.
      for I in Numero_Filtre_T'Range loop
         --  Décalage à gauche pour le chiffrement.
         Clef_56.Decaler_Bits_A_Gauche (Table_Decalage (I));
         declare
            E : Des_P.Etage_P.Filtrage_P.Etage_T;
            --  Initialise le filtre avec la clef de 48
            --  qui lui est spécifique.
            F : constant Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class :=
               Fabrique.Fabriquer_Corps
                  (Des_P.Faiseur_P.Faire_Clef (Faiseur_48, Clef_56));
         begin
            E.Modifier_Filtre (F);
            --  Ajoute l'étage à la fin de la chaine.
            Tete.Ajouter_Successeur (E);
         end;
      end loop;

      --  Ajoute le filtre de sortie au dernier étage.
      declare
         Etage : Des_P.Etage_P.Filtrage_P.Etage_T;
      begin
         Etage.Modifier_Filtre (Fabrique.Fabriquer_Sortie);
         Tete.Ajouter_Successeur (Etage);
      end;

      --  Change la tète de la chaine.
      Constructeur.Chaine.Tete := Tete;
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

end Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P;
