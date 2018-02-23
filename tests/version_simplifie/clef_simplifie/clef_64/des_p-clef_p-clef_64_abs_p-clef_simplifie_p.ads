with Des_P.Clef_P.Constructeur_56_Abs_P;

with Des_P.Clef_P.Constructeur_56_Abs_P.Holder_P;

package Des_P.Clef_P.Clef_64_Abs_P.Clef_Simplifie_P is

   use Des_P.Clef_P.Constructeur_56_Abs_P;

   type Clef_Simplifie_T is new Clef_64_Abs_T with private;

   type Tableau_Bits_T is array (Intervalle_Clef_64_T) of Bit_T;

   procedure Init
      (
         Clef : out Clef_Simplifie_T;
         Champ : Tableau_Bits_T;
         Constructeur : Constructeur_Clef_56_Abs_T'Class
      );

   overriding
   function Possede_Constructeur_56 (Clef : Clef_Simplifie_T) return Boolean;

   overriding
   function Possede_Constructeur_48 (Clef : Clef_Simplifie_T) return Boolean;

   overriding
   function Lire_Bit
      (Clef : Clef_Simplifie_T; Position : Intervalle_Clef_64_T)
      return Bit_T;

   overriding
   function Lire_Clef_56 (Clef : Clef_Simplifie_T)
      return Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Clef_56_T;

   overriding
   procedure Initialize (Clef : in out Clef_Simplifie_T);

   overriding
   procedure Finalize (Clef : in out Clef_Simplifie_T);

   overriding
   procedure Adjust (Clef : in out Clef_Simplifie_T);

private

   type Clef_Simplifie_T is new Clef_64_Abs_T with
      record
         Champ : Tableau_Bits_T;
         Constructeur : Des_P.Clef_P.Constructeur_56_Abs_P.Holder_P.Holder;
      end record;

end Des_P.Clef_P.Clef_64_Abs_P.Clef_Simplifie_P;
