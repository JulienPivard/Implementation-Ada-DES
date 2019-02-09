with AUnit;
with AUnit.Test_Fixtures;

package Des_P.Bloc_P.Bloc_64_P.Test_P is

   type Bit_IO_T is range 0 .. 1;

   type Interval_Nb_Conf_Genere_T is range 1 .. 128;

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Bloc : Bloc_64_T;
      end record;

   overriding
   procedure Set_Up (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down (T : in out Test_Fixt_T);

   procedure Test_Initialisation
      (T : in out Test_Fixt_T);

   procedure Test_Modification_Un_Bit_Par_Un_Bit
      (T : in out Test_Fixt_T);

   procedure Test_Bits_Aleatoire
      (T : in out Test_Fixt_T);

   procedure Test_Bits_Aleatoire_Par_Bloc
      (T : in out Test_Fixt_T);

   procedure Test_Bits_Aleatoire_1_Echange
      (T : in out Test_Fixt_T);

   procedure Test_Bits_Aleatoire_Par_Bloc_1_Echange
      (T : in out Test_Fixt_T);

   procedure Test_Bits_Aleatoire_2_Echanges
      (T : in out Test_Fixt_T);

   procedure Test_Bits_Aleatoire_Par_Bloc_2_Echanges
      (T : in out Test_Fixt_T);

   procedure Test_Lecture_Bloc_32_Aleatoire
      (T : in out Test_Fixt_T);

   procedure Test_Ecriture_Bloc_32_Aleatoire
      (T : in out Test_Fixt_T);

   procedure Test_Lecture_Bloc_32_Aleatoire_1_Echange
      (T : in out Test_Fixt_T);

   procedure Test_Ecriture_Bloc_32_Aleatoire_1_Echange
      (T : in out Test_Fixt_T);

   procedure Test_Lecture_Bloc_32_Aleatoire_2_Echange
      (T : in out Test_Fixt_T);

   procedure Test_Ecriture_Bloc_32_Aleatoire_2_Echange
      (T : in out Test_Fixt_T);

end Des_P.Bloc_P.Bloc_64_P.Test_P;
