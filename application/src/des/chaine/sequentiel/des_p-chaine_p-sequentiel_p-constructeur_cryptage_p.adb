with Des_P.Clef_P.Clef_48_P;
with Des_P.Clef_P.Clef_56_P.Constructeur_P;
with Des_P.Clef_P.Clef_48_P.Constructeur_P;
with Des_P.Filtre_P.Corps_P;
with Des_P.Filtre_P.Fabrique_P.Cryptage_P;

package body Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P is

   ---------------------------------------------------------------------------
   procedure Initialiser (Constructeur : in out Constructeur_Cryptage_T) is
      C : Chaine_T;
   begin
      Constructeur.Chaine := C;
   end Initialiser;

   ---------------------------------------------------------------------------
   procedure Construire
      (
         Constructeur : in out Constructeur_Cryptage_T;
         Clef : Des_P.Clef_P.Clef_64_I_P.Clef_Interface_T'Class
      )
   is
      Tete : Des_P.Etage_P.Filtrage_P.Etage_T;
      Fabrique : Des_P.Filtre_P.Fabrique_P.Cryptage_P.Fabrique_T;
      C_56 : Des_P.Clef_P.Clef_56_P.Constructeur_P.Constructeur_Clef_T;
      C_48 : Des_P.Clef_P.Clef_48_P.Constructeur_P.Constructeur_Clef_T;
      Clef_56 : Des_P.Clef_P.Clef_56_P.Clef_T;
   begin
      C_56.Preparer_Nouvelle_Clef;
      C_56.Construire_Clef (Clef);
      Clef_56 := C_56.Recuperer_Clef;

      Tete.Modifier_Filtre (Fabrique.Fabriquer_Entree);
      for I in Numero_Filtre_T'Range loop
         Clef_56.Decaler_Bits_A_Gauche (Table_Decalage (I));
         C_48.Preparer_Nouvelle_Clef;
         C_48.Construire_Clef (Clef_56);
         declare
            Clef_48 : constant Des_P.Clef_P.Clef_48_P.Clef_T :=
               C_48.Recuperer_Clef;
            E : Des_P.Etage_P.Filtrage_P.Etage_T;
            F : constant Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class :=
               Fabrique.Fabriquer_Corps (Clef_48);
         begin
            E.Modifier_Filtre (F);
            Tete.Ajouter_Successeur (E);
         end;
      end loop;

      declare
         Etage : Des_P.Etage_P.Filtrage_P.Etage_T;
      begin
         Etage.Modifier_Filtre (Fabrique.Fabriquer_Sortie);
         Tete.Ajouter_Successeur (Etage);
      end;

      Constructeur.Chaine.Tete := Tete;
   end Construire;

   ---------------------------------------------------------------------------
   function Recuperer_Chaine
      (Constructeur : Constructeur_Cryptage_T)
      return Chaine_T
   is
   begin
      return Constructeur.Chaine;
   end Recuperer_Chaine;

end Des_P.Chaine_P.Sequentiel_P.Constructeur_Cryptage_P;
