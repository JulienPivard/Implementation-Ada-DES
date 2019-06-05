package body Des_P.Bloc_P.Bloc_48_P.Faiseur_P is

   ---------------------------------------------------------------------------
   procedure Preparer_Nouveau_Bloc
      (Constructeur : in out Faiseur_Bloc_T)
   is
      B : Bloc_48_T;
   begin
      Constructeur.Bloc := B;
   end Preparer_Nouveau_Bloc;

   ---------------------------------------------------------------------------
   procedure Construire_Bloc
      (
         Constructeur : in out Faiseur_Bloc_T;
         Brut         :        Des_P.Bloc_P.Bloc_32_P.Bloc_32_T
      )
   is
      type Table_Selection_E_T is array
         (Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T)
         of Des_P.Bloc_P.Bloc_32_P.Intervalle_T;

      --  La table de sélection E pour étendre le bloc de 32 bits
      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "Positional_Components",
            "Tableau trop grand pour positionner toutes les valeurs"
         );
      Table_E : constant Table_Selection_E_T :=
         Table_Selection_E_T'
         (
            32,  1,  2,  3,  4,  5,
             4,  5,  6,  7,  8,  9,
             8,  9, 10, 11, 12, 13,
            12, 13, 14, 15, 16, 17,
            16, 17, 18, 19, 20, 21,
            20, 21, 22, 23, 24, 25,
            24, 25, 26, 27, 28, 29,
            28, 29, 30, 31, 32,  1
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "Positional_Components"
         );
   begin
      --  Remplissage du bloc de 48 avec le bloc de 32.
      for I in Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T loop
         Constructeur.Bloc.Bits (I) :=
            Brut.Lire_Bit (Position => Table_E (I));
      end loop;
   end Construire_Bloc;

   ---------------------------------------------------------------------------
   function Recuperer_Bloc
      (Constructeur : Faiseur_Bloc_T)
      return Bloc_48_T
   is
   begin
      return Constructeur.Bloc;
   end Recuperer_Bloc;

end Des_P.Bloc_P.Bloc_48_P.Faiseur_P;
