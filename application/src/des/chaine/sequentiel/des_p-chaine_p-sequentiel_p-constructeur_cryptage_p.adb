with Des_P.Clef_P.Clef_56_Abs_P;
with Des_P.Filtre_P.Corps_P;
with Des_P.Filtre_P.Fabrique_P.Fabrique_Cryptage_P;

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
         Clef : Des_P.Clef_P.Clef_64_Abs_P.Clef_64_Abs_T'Class
      )
   is
      Tete : Des_P.Etage_P.Filtrage_P.Etage_T;
      Fabrique : Des_P.Filtre_P.Fabrique_P.Fabrique_Cryptage_P.Fabrique_T;
      Clef_56 : Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class :=
         Clef.Lire_Clef_56;
   begin
      Tete.Modifier_Filtre (Fabrique.Fabriquer_Entree);
      for I in Position_Filtre_T'Range loop
         declare
            E : Des_P.Etage_P.Filtrage_P.Etage_T;
            F : Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class :=
               Fabrique.Fabriquer_Corps;
         begin

            Clef_56.Decaler_Bits_A_Gauche (Table_Decalage (I));
            F.Modifier_Clef (Clef_56.Lire_Clef_48);

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
