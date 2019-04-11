with System;

package body Des_P.Bloc_P.Bloc_32_P.Faiseur_P is

   ---------------------------------------------------------------------------
   procedure Preparer_Nouveau_Bloc
      (Constructeur : in out Faiseur_Bloc_T)
   is
      B : Bloc_32_T;
   begin
      Constructeur.Bloc := B;
   end Preparer_Nouveau_Bloc;

   ---------------------------------------------------------------------------
   procedure Construire_Bloc
      (
         Constructeur : in out Faiseur_Bloc_T;
         Brut         : Bloc_32_Brut_T
      )
   is
      Resultat : Tableau_Bits_T with Address => Brut'Address;
   begin
      Constructeur.Bloc.Bits := Resultat;
   end Construire_Bloc;

   ---------------------------------------------------------------------------
   procedure Construire_Bloc
      (
         Constructeur : in out Faiseur_Bloc_T;
         Bloc         : Bloc_32_T
      )
   is
      type Table_Permutations_T is array (Intervalle_T) of Intervalle_T;
      --  La table de permutations P.
      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "Positional_Components",
            "Tableau trop grand pour positionner toutes les valeurs"
         );
      Table_P : constant Table_Permutations_T :=
         Table_Permutations_T'
         (
            16,  7, 20, 21,
            29, 12, 28, 17,
             1, 15, 23, 26,
             5, 18, 31, 10,
             2,  8, 24, 14,
            32, 27,  3,  9,
            19, 13, 30,  6,
            22, 11,  4, 25
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "Positional_Components"
         );
   begin
      for I in Intervalle_T loop
         Constructeur.Bloc.Bits (I) := Bloc.Bits (Table_P (I));
      end loop;
   end Construire_Bloc;

   ---------------------------------------------------------------------------
   procedure Construire_Bloc
      (
         Constructeur : in out Faiseur_Bloc_T;
         Bloc         : Des_P.Bloc_P.Bloc_48_I_P.Bloc_Interface_T'Class
      )
   is
      type Table_48_Bits_T is array
         (Des_P.Bloc_P.Bloc_48_I_P.Intervalle_T)
         of Bit_T
         with Size => 48, Pack;

      --  Extraction de la table de 48 bits pour pouvoir la manipuler.
      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "Positional_Components",
            "Tableau trop grand pour positionner toutes les valeurs"
         );
      Table_48_Bits : constant Table_48_Bits_T :=
      Table_48_Bits_T'
      (
         Bloc.Lire_Bit (1),  Bloc.Lire_Bit (2),  Bloc.Lire_Bit (3),
         Bloc.Lire_Bit (4),  Bloc.Lire_Bit (5),  Bloc.Lire_Bit (6),
         Bloc.Lire_Bit (7),  Bloc.Lire_Bit (8),  Bloc.Lire_Bit (9),
         Bloc.Lire_Bit (10), Bloc.Lire_Bit (11), Bloc.Lire_Bit (12),
         Bloc.Lire_Bit (13), Bloc.Lire_Bit (14), Bloc.Lire_Bit (15),
         Bloc.Lire_Bit (16), Bloc.Lire_Bit (17), Bloc.Lire_Bit (18),
         Bloc.Lire_Bit (19), Bloc.Lire_Bit (20), Bloc.Lire_Bit (21),
         Bloc.Lire_Bit (22), Bloc.Lire_Bit (23), Bloc.Lire_Bit (24),
         Bloc.Lire_Bit (25), Bloc.Lire_Bit (26), Bloc.Lire_Bit (27),
         Bloc.Lire_Bit (28), Bloc.Lire_Bit (29), Bloc.Lire_Bit (30),
         Bloc.Lire_Bit (31), Bloc.Lire_Bit (32), Bloc.Lire_Bit (33),
         Bloc.Lire_Bit (34), Bloc.Lire_Bit (35), Bloc.Lire_Bit (36),
         Bloc.Lire_Bit (37), Bloc.Lire_Bit (38), Bloc.Lire_Bit (39),
         Bloc.Lire_Bit (40), Bloc.Lire_Bit (41), Bloc.Lire_Bit (42),
         Bloc.Lire_Bit (43), Bloc.Lire_Bit (44), Bloc.Lire_Bit (45),
         Bloc.Lire_Bit (46), Bloc.Lire_Bit (47), Bloc.Lire_Bit (48)
      );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "Positional_Components"
         );

      --  Le numéro de la colonne.
      type Colonne_T is mod 2**4
         with Size => 4;
      --  Le bit de début et de fin qui vont composer le numéro de la ligne.
      type Debut_Fin_T is mod 2
         with Size => 1;
      --  Passage par un bloc intermédiaire pour pouvoir manipuler plus
      --  facilement les bits.
      type Bloc_Intermediaire_T is
         record
            Debut_1     : Debut_Fin_T;
            Colonne_1   : Colonne_T;
            Fin_1       : Debut_Fin_T;
            Debut_2     : Debut_Fin_T;
            Colonne_2   : Colonne_T;
            Fin_2       : Debut_Fin_T;
            Debut_3     : Debut_Fin_T;
            Colonne_3   : Colonne_T;
            Fin_3       : Debut_Fin_T;
            Debut_4     : Debut_Fin_T;
            Colonne_4   : Colonne_T;
            Fin_4       : Debut_Fin_T;

            Debut_5     : Debut_Fin_T;
            Colonne_5   : Colonne_T;
            Fin_5       : Debut_Fin_T;
            Debut_6     : Debut_Fin_T;
            Colonne_6   : Colonne_T;
            Fin_6       : Debut_Fin_T;
            Debut_7     : Debut_Fin_T;
            Colonne_7   : Colonne_T;
            Fin_7       : Debut_Fin_T;
            Debut_8     : Debut_Fin_T;
            Colonne_8   : Colonne_T;
            Fin_8       : Debut_Fin_T;
         end record
      with Size => 48;

      --  Découpage de la table pour faciliter les manipulations.
      for Bloc_Intermediaire_T use
         record
            Debut_1     at 0 range 0 .. 0;
            Colonne_1   at 0 range 1 .. 4;
            Fin_1       at 0 range 5 .. 5;
            Debut_2     at 0 range 6 .. 6;
            Colonne_2   at 0 range 7 .. 10;
            Fin_2       at 0 range 11 .. 11;
            Debut_3     at 0 range 12 .. 12;
            Colonne_3   at 0 range 13 .. 16;
            Fin_3       at 0 range 17 .. 17;
            Debut_4     at 0 range 18 .. 18;
            Colonne_4   at 0 range 19 .. 22;
            Fin_4       at 0 range 23 .. 23;

            Debut_5     at 3 range 0 .. 0;
            Colonne_5   at 3 range 1 .. 4;
            Fin_5       at 3 range 5 .. 5;
            Debut_6     at 3 range 6 .. 6;
            Colonne_6   at 3 range 7 .. 10;
            Fin_6       at 3 range 11 .. 11;
            Debut_7     at 3 range 12 .. 12;
            Colonne_7   at 3 range 13 .. 16;
            Fin_7       at 3 range 17 .. 17;
            Debut_8     at 3 range 18 .. 18;
            Colonne_8   at 3 range 19 .. 22;
            Fin_8       at 3 range 23 .. 23;
         end record;

      for Bloc_Intermediaire_T'Bit_Order            use System.Low_Order_First;
      for Bloc_Intermediaire_T'Scalar_Storage_Order use System.Low_Order_First;

      --  Transformation du tableau en bloc de bits.
      Bloc_Intermediaire : Bloc_Intermediaire_T
         with Address => Table_48_Bits'Address;

      --  Représentation final de la ligne.
      type Ligne_T is mod 2**2
         with Size => 8;
      --  Représentation intermédiaire de la ligne.
      --  La taille de la table utilisée est déterminée par la taille réel
      --  du type vers lequel la conversion est faite pour éviter
      --  des bits parasites au delà des deux que l'ont veut convertir.
      subtype Indice_Intermediaire_T is Natural range 1 .. Ligne_T'Base'Size;
      type Ligne_Intermediaire_T is array
         (Indice_Intermediaire_T)
         of Debut_Fin_T
         with Size => Ligne_T'Base'Size, Pack;

      --  Rassemble le bit de début et de fin
      --  pour former le numéro de la ligne.
      --  Transforme le tableau de bits en un octet.
      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "OTHERS_In_Aggregates",
            "Initialisation de tableau"
         );
      Ligne_Intermediaire_1 : constant Ligne_Intermediaire_T :=
         Ligne_Intermediaire_T'
         (
            1        => Bloc_Intermediaire.Debut_1,
            2        => Bloc_Intermediaire.Fin_1,
            others   => 0
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "OTHERS_In_Aggregates"
         );
      Ligne_1 : Ligne_T with Address => Ligne_Intermediaire_1'Address;

      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "OTHERS_In_Aggregates",
            "Initialisation de tableau"
         );
      Ligne_Intermediaire_2 : constant Ligne_Intermediaire_T :=
         Ligne_Intermediaire_T'
         (
            1        => Bloc_Intermediaire.Debut_2,
            2        => Bloc_Intermediaire.Fin_2,
            others   => 0
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "OTHERS_In_Aggregates"
         );
      Ligne_2 : Ligne_T with Address => Ligne_Intermediaire_2'Address;

      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "OTHERS_In_Aggregates",
            "Initialisation de tableau"
         );
      Ligne_Intermediaire_3 : constant Ligne_Intermediaire_T :=
         Ligne_Intermediaire_T'
         (
            1        => Bloc_Intermediaire.Debut_3,
            2        => Bloc_Intermediaire.Fin_3,
            others   => 0
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "OTHERS_In_Aggregates"
         );
      Ligne_3 : Ligne_T with Address => Ligne_Intermediaire_3'Address;

      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "OTHERS_In_Aggregates",
            "Initialisation de tableau"
         );
      Ligne_Intermediaire_4 : constant Ligne_Intermediaire_T :=
         Ligne_Intermediaire_T'
         (
            1        => Bloc_Intermediaire.Debut_4,
            2        => Bloc_Intermediaire.Fin_4,
            others   => 0
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "OTHERS_In_Aggregates"
         );
      Ligne_4 : Ligne_T with Address => Ligne_Intermediaire_4'Address;

      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "OTHERS_In_Aggregates",
            "Initialisation de tableau"
         );
      Ligne_Intermediaire_5 : constant Ligne_Intermediaire_T :=
         Ligne_Intermediaire_T'
         (
            1        => Bloc_Intermediaire.Debut_5,
            2        => Bloc_Intermediaire.Fin_5,
            others   => 0
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "OTHERS_In_Aggregates"
         );
      Ligne_5 : Ligne_T with Address => Ligne_Intermediaire_5'Address;

      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "OTHERS_In_Aggregates",
            "Initialisation de tableau"
         );
      Ligne_Intermediaire_6 : constant Ligne_Intermediaire_T :=
         Ligne_Intermediaire_T'
         (
            1        => Bloc_Intermediaire.Debut_6,
            2        => Bloc_Intermediaire.Fin_6,
            others   => 0
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "OTHERS_In_Aggregates"
         );
      Ligne_6 : Ligne_T with Address => Ligne_Intermediaire_6'Address;

      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "OTHERS_In_Aggregates",
            "Initialisation de tableau"
         );
      Ligne_Intermediaire_7 : constant Ligne_Intermediaire_T :=
         Ligne_Intermediaire_T'
         (
            1        => Bloc_Intermediaire.Debut_7,
            2        => Bloc_Intermediaire.Fin_7,
            others   => 0
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "OTHERS_In_Aggregates"
         );
      Ligne_7 : Ligne_T with Address => Ligne_Intermediaire_7'Address;

      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "OTHERS_In_Aggregates",
            "Initialisation de tableau"
         );
      Ligne_Intermediaire_8 : constant Ligne_Intermediaire_T :=
         Ligne_Intermediaire_T'
         (
            1        => Bloc_Intermediaire.Debut_8,
            2        => Bloc_Intermediaire.Fin_8,
            others   => 0
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "OTHERS_In_Aggregates"
         );
      Ligne_8 : Ligne_T with Address => Ligne_Intermediaire_8'Address;

      --  La valeur contenu dans le tableau au
      --  croisement de la ligne et de la colonne.
      type Valeur_T is mod 2**4
         with Size => 4;
      type Table_De_Selection_T is array (Ligne_T, Colonne_T) of Valeur_T;

      --  Les tables de sélection recommandé dans le standard de S1 à S8
      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "Positional_Components",
            "Tableau trop grand pour positionner toutes les valeurs"
         );
      S1 : constant Table_De_Selection_T :=
         Table_De_Selection_T'
         (
         --   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
            (14, 04, 13, 01, 02, 15, 11, 08, 03, 10, 06, 12, 05, 09, 00, 07),
            (00, 15, 07, 04, 14, 02, 13, 01, 10, 06, 12, 11, 09, 05, 03, 08),
            (04, 01, 14, 08, 13, 06, 02, 11, 15, 12, 09, 07, 03, 10, 05, 00),
            (15, 12, 08, 02, 04, 09, 01, 07, 05, 11, 03, 14, 10, 00, 06, 13)
         --   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "Positional_Components"
         );

      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "Positional_Components",
            "Tableau trop grand pour positionner toutes les valeurs"
         );
      S2 : constant Table_De_Selection_T :=
         Table_De_Selection_T'
         (
         --   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
            (15, 01, 08, 14, 06, 11, 03, 04, 09, 07, 02, 13, 12, 00, 05, 10),
            (03, 13, 04, 07, 15, 02, 08, 14, 12, 00, 01, 10, 06, 09, 11, 05),
            (00, 14, 07, 11, 10, 04, 13, 01, 05, 08, 12, 06, 09, 03, 02, 15),
            (13, 08, 10, 01, 03, 15, 04, 02, 11, 06, 07, 12, 00, 05, 14, 09)
         --   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "Positional_Components"
         );

      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "Positional_Components",
            "Tableau trop grand pour positionner toutes les valeurs"
         );
      S3 : constant Table_De_Selection_T :=
         Table_De_Selection_T'
         (
         --   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
            (10, 00, 09, 14, 06, 03, 15, 05, 01, 13, 12, 07, 11, 04, 02, 08),
            (13, 07, 00, 09, 03, 04, 06, 10, 02, 08, 05, 14, 12, 11, 15, 01),
            (13, 06, 04, 09, 08, 15, 03, 00, 11, 01, 02, 12, 05, 10, 14, 07),
            (01, 10, 13, 00, 06, 09, 08, 07, 04, 15, 14, 03, 11, 05, 02, 12)
         --   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "Positional_Components"
         );

      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "Positional_Components",
            "Tableau trop grand pour positionner toutes les valeurs"
         );
      S4 : constant Table_De_Selection_T :=
         Table_De_Selection_T'
         (
         --   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
            (07, 13, 14, 03, 00, 06, 09, 10, 01, 02, 08, 05, 11, 12, 04, 15),
            (13, 08, 11, 05, 06, 15, 00, 03, 04, 07, 02, 12, 01, 10, 14, 09),
            (10, 06, 09, 00, 12, 11, 07, 13, 15, 01, 03, 14, 05, 02, 08, 04),
            (03, 15, 00, 06, 10, 01, 13, 08, 09, 04, 05, 11, 12, 07, 02, 14)
         --   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "Positional_Components"
         );

      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "Positional_Components",
            "Tableau trop grand pour positionner toutes les valeurs"
         );
      S5 : constant Table_De_Selection_T :=
         Table_De_Selection_T'
         (
         --   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
            (02, 12, 04, 01, 07, 10, 11, 06, 08, 05, 03, 15, 13, 00, 14, 09),
            (14, 11, 02, 12, 04, 07, 13, 01, 05, 00, 15, 10, 03, 09, 08, 06),
            (04, 02, 01, 11, 10, 13, 07, 08, 15, 09, 12, 05, 06, 03, 00, 14),
            (11, 08, 12, 07, 01, 14, 02, 13, 06, 15, 00, 09, 10, 04, 05, 03)
         --   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "Positional_Components"
         );

      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "Positional_Components",
            "Tableau trop grand pour positionner toutes les valeurs"
         );
      S6 : constant Table_De_Selection_T :=
         Table_De_Selection_T'
         (
         --   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
            (12, 01, 10, 15, 09, 02, 06, 08, 00, 13, 03, 04, 14, 07, 05, 11),
            (10, 15, 04, 02, 07, 12, 09, 05, 06, 01, 13, 14, 00, 11, 03, 08),
            (09, 14, 15, 05, 02, 08, 12, 03, 07, 00, 04, 10, 01, 13, 11, 06),
            (04, 03, 02, 12, 09, 05, 15, 10, 11, 14, 01, 07, 06, 00, 08, 13)
         --   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "Positional_Components"
         );

      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "Positional_Components",
            "Tableau trop grand pour positionner toutes les valeurs"
         );
      S7 : constant Table_De_Selection_T :=
         Table_De_Selection_T'
         (
         --   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
            (04, 11, 02, 14, 15, 00, 08, 13, 03, 12, 09, 07, 05, 10, 06, 01),
            (13, 00, 11, 07, 04, 09, 01, 10, 14, 03, 05, 12, 02, 15, 08, 06),
            (01, 04, 11, 13, 12, 03, 07, 14, 10, 15, 06, 08, 00, 05, 09, 02),
            (06, 11, 13, 08, 01, 04, 10, 07, 09, 05, 00, 15, 14, 02, 03, 12)
         --   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "Positional_Components"
         );

      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "Positional_Components",
            "Tableau trop grand pour positionner toutes les valeurs"
         );
      S8 : constant Table_De_Selection_T :=
         Table_De_Selection_T'
         (
         --   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
            (13, 02, 08, 04, 06, 15, 11, 01, 10, 09, 03, 14, 05, 00, 12, 07),
            (01, 15, 13, 08, 10, 03, 07, 04, 12, 05, 06, 11, 00, 14, 09, 02),
            (07, 11, 04, 01, 09, 12, 14, 02, 00, 06, 10, 13, 15, 03, 05, 08),
            (02, 01, 14, 07, 04, 10, 08, 13, 15, 12, 09, 00, 03, 05, 06, 11)
         --   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
         );
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "Positional_Components"
         );

      --  Tableau de 8 blocs de 8 bits.
      subtype Indice_32_Tmp_T is Natural range 0 .. 7;
      type Bloc_32_Intermediaire_T is array (Indice_32_Tmp_T) of Valeur_T
         with Size => 32, Pack;

      --  Table de 8 valeurs qui va contenir les résultats
      --  des tables de sélection.
      Bloc_Tmp : constant Bloc_32_Intermediaire_T :=
         Bloc_32_Intermediaire_T'
         (
            0 => S1 (Ligne_1, Bloc_Intermediaire.Colonne_1),
            1 => S2 (Ligne_2, Bloc_Intermediaire.Colonne_2),
            2 => S3 (Ligne_3, Bloc_Intermediaire.Colonne_3),
            3 => S4 (Ligne_4, Bloc_Intermediaire.Colonne_4),
            4 => S5 (Ligne_5, Bloc_Intermediaire.Colonne_5),
            5 => S6 (Ligne_6, Bloc_Intermediaire.Colonne_6),
            6 => S7 (Ligne_7, Bloc_Intermediaire.Colonne_7),
            7 => S8 (Ligne_8, Bloc_Intermediaire.Colonne_8)
         );

      --  Le tableau de 8 bloc de 8 bits est transformé en un bloc
      --  de 32 bits brut.
      Bloc_Brut : Bloc_32_Brut_T with Address => Bloc_Tmp'Address;
   begin
      Construire_Bloc (Constructeur, Bloc_Brut);
   end Construire_Bloc;

   ---------------------------------------------------------------------------
   function Recuperer_Bloc
      (Constructeur : Faiseur_Bloc_T)
      return Bloc_32_T
   is
   begin
      return Constructeur.Bloc;
   end Recuperer_Bloc;

   ---------------------------------------------------------------------------
   function Transformer_En_Brut
      (
         Constructeur : in out Faiseur_Bloc_T;
         Bloc         : Bloc_32_T
      )
      return Bloc_32_Brut_T
   is
      pragma Unreferenced (Constructeur);
      --  Le tableau de 32 bits est transformé en un bloc de 32 bits.
      Brut : Bloc_32_Brut_T with Address => Bloc.Bits'Address;
   begin
      return Brut;
   end Transformer_En_Brut;

end Des_P.Bloc_P.Bloc_32_P.Faiseur_P;
