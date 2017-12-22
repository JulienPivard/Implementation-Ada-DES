with Des_P.Clef_P.Constructeur_48_Abs_P;

package Des_P.Clef_P.Clef_56_Abs_P.Clef_Simplifie_P is

   pragma Pure;
   use Des_P.Clef_P.Constructeur_48_Abs_P;

   type Clef_Simplifie_T is new Clef_56_Abs_T with private;

   type Champ_De_Bits_T is array (Intervalle_Clef_56_T) of Bit_T;

   procedure Init
      (
         Clef : out Clef_Simplifie_T;
         Champ : Champ_De_Bits_T;
         Constructeur : access Constructeur_Clef_48_Abs_T'Class
      );

   overriding
   function Possede_Constructeur_48 (Clef : Clef_Simplifie_T)
      return Boolean;

   overriding
   procedure Decaler_Bits_A_Gauche
      (Clef : in out Clef_Simplifie_T; Nb_Decalage : Decalage_T := 1);

   overriding
   function Lire_Bit
      (Clef : Clef_Simplifie_T; Position : Intervalle_Clef_56_T)
      return Bit_T;

   overriding
   function Lire_Clef_48 (Clef : Clef_Simplifie_T)
      return Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Clef_48_T;

   overriding
   procedure Initialize (Clef : in out Clef_Simplifie_T);

   overriding
   procedure Finalize (Clef : in out Clef_Simplifie_T);

   overriding
   procedure Adjust (Clef : in out Clef_Simplifie_T);

private

   type Clef_Simplifie_T is new Clef_56_Abs_T with
      record
         Champ : Champ_De_Bits_T;
         Constructeur : access Constructeur_Clef_48_Abs_T'Class;
      end record;

end Des_P.Clef_P.Clef_56_Abs_P.Clef_Simplifie_P;
