with Des_P.Filtre_P.Fabrique_P.Fabrique_Decryptage_P;
with Des_P.Filtre_P.Corps_P;

package body Des_P.Chaine_P.Sequentiel_P.Constructeur_Decryptage_P is

   ---------------------------------------------------------------------------
   procedure Initialiser (Constructeur : in out Constructeur_Decryptage_T) is
      C : Chaine_T;
   begin
      Constructeur.Chaine := C;
   end Initialiser;

   ---------------------------------------------------------------------------
   procedure Construire
      (
         Constructeur : in out Constructeur_Decryptage_T;
         Clef : Des_P.Clef_P.Clef_64_Abs_P.Clef_64_Abs_T'Class
      )
   is
      Tete : Des_P.Etage_P.Filtrage_P.Etage_T;
      Fabrique : Des_P.Filtre_P.Fabrique_P.Fabrique_Decryptage_P.Fabrique_T;
      Clef_56 : Des_P.Clef_P.Clef_56_Abs_P.Clef_56_Abs_T'Class :=
         Clef.Lire_Clef_56;
      use type Des_P.Clef_P.Clef_56_Abs_P.Decalage_T;
   begin
      Tete.Modifier_Filtre (Fabrique.Fabriquer_Entree);
      for I in reverse Des_P.Filtre_P.Corps_P.Numero_Filtre_T'Range loop
         declare
            E : Des_P.Etage_P.Filtrage_P.Etage_T;
            F : Des_P.Filtre_P.Corps_P.Corps_Abstrait_T'Class :=
               Fabrique.Fabriquer_Corps;
         begin
            F.Modifier_Numero (I);
            E.Modifier_Filtre (F);
            Clef_56.Decaler_Bits_A_Gauche
               (-1 * Table_Decalage (Position_Filtre_T (I)));
            E.Modifier_Clef (Clef_56.Lire_Clef_48);
            Tete.Ajouter_Successeur (E);
         end;
      end loop;
      declare
         Etage : Des_P.Etage_P.Filtrage_P.Etage_T;
      begin
         Etage.Modifier_Filtre (Fabrique.Fabriquer_Sortie);
         Tete.Ajouter_Successeur (Etage);
      end;

      Constructeur.Chaine.Clef :=
         Des_P.Clef_P.Clef_56_Abs_P.Holder_P.To_Holder (Clef.Lire_Clef_56);
      Constructeur.Chaine.Tete := Tete;
   end Construire;

   ---------------------------------------------------------------------------
   function Recuperer_Chaine
      (Constructeur : Constructeur_Decryptage_T)
      return Chaine_T
   is
   begin
      return Constructeur.Chaine;
   end Recuperer_Chaine;

end Des_P.Chaine_P.Sequentiel_P.Constructeur_Decryptage_P;
