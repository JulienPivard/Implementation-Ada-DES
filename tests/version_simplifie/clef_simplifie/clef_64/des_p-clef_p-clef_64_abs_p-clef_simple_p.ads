with Des_P.Clef_P.Constructeur_48_Abs_P;
with Des_P.Clef_P.Constructeur_56_Abs_P;

package Des_P.Clef_P.Clef_64_Abs_P.Clef_Simple_P is

   pragma Pure;

   use Des_P.Clef_P.Constructeur_48_Abs_P;
   use Des_P.Clef_P.Constructeur_56_Abs_P;

   type Champ_De_Bits_T is array (Intervalle_Clef_64_T) of Bit_T;

   type Clef_Simple_T is new Clef_64_Abs_T with private;

   procedure Init
      (
         Clef : out Clef_Simple_T;
         Champ : Champ_De_Bits_T;
         Constructeur_56 : access Constructeur_Clef_56_Abs_T'Class;
         Constructeur_48 : access Constructeur_Clef_48_Abs_T'Class
      );

   overriding
   function Possede_Constructeur_56 (Clef : Clef_Simple_T) return Boolean;

   overriding
   function Possede_Constructeur_48 (Clef : Clef_Simple_T) return Boolean;

   overriding
   function Lire_Bit
      (Clef : Clef_Simple_T; Position : Intervalle_Clef_64_T)
      return Bit_T;

   overriding
   function Lire_Clef_56 (Clef : Clef_Simple_T)
      return Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Clef_56_T;

   overriding
   procedure Initialize (Clef : in out Clef_Simple_T);

   overriding
   procedure Finalize (Clef : in out Clef_Simple_T);

   overriding
   procedure Adjust (Clef : in out Clef_Simple_T);

private

   type Clef_Simple_T is new Clef_64_Abs_T with
      record
         Champ : Champ_De_Bits_T;
         Constructeur_56 : access Constructeur_Clef_56_Abs_T'Class;
         Constructeur_48 : access Constructeur_Clef_48_Abs_T'Class;
      end record;

end Des_P.Clef_P.Clef_64_Abs_P.Clef_Simple_P;
