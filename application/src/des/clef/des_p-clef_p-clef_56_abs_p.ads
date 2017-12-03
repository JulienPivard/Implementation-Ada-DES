with Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P;

--  @summary
--  Une clef abstraite de 56 bits.
--  @description
--  La représentation d'une clef de 56 bits est construite
--  à partir d'une clef de 64. Le constructeur se charge de
--  sélectionner les bits.
--  @group Clef
package Des_P.Clef_P.Clef_56_Abs_P is

   pragma Pure;

   --  La clef de 56 bits.
   type Clef_56_Abs_T is abstract new Clef_Abstraite_T with private;

   --  L'intervalle de bit qui est contenu dans la clef.
   type Intervalle_Clef_56_T is range 1 .. 56;

   --  Le nombre de décalage à gauche.
   type Decalage_T is mod 28;

   --  Indique si un constructeur de clef 48 bits à été attribué.
   --  @param Clef
   --  La clef de 56 bits.
   --  @return La clef possède un constructeur de clef 48 bits initialisé.
   function Possede_Constructeur_48 (Clef : Clef_56_Abs_T)
      return Boolean is abstract;

   --  Décale les bits de la clef vers la gauche
   --  @param Clef
   --  La clef dont on veut décaler les bits.
   --  @param Nb_Decalage
   --  Le nombre de décalages vers la gauche. Par défaut 1.
   procedure Decaler_Bits_A_Gauche
      (Clef : in out Clef_56_Abs_T; Nb_Decalage : Decalage_T := 1)
   is abstract;

   --  Lit un bit spécifié.
   --  @param Clef
   --  La clef dont on veut lire un bit.
   --  @param Position
   --  La position du bit que l'on veut lire.
   --  @return Le bit lu.
   function Lire_Bit
      (Clef : Clef_56_Abs_T; Position : Intervalle_Clef_56_T)
      return Bit_T is abstract;

   --  Permet de générer une clef de 48 bits. Cette clef est construite
   --  grâce au décalage PC-2 décrit dans le standard DES.
   --  @param Clef
   --  La clef de 56 bits.
   --  @return La sous clef de 48 bits.
   function Lire_Clef_48 (Clef : Clef_56_Abs_T)
      return Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Clef_48_T is abstract;

   overriding
   --  Création d'une clef vide par défaut.
   --  @param Clef
   --  La clef.
   procedure Initialize (Clef : in out Clef_56_Abs_T) is abstract;

   overriding
   --  Supprime la clef.
   --  @param Clef
   --  La clef.
   procedure Finalize (Clef : in out Clef_56_Abs_T) is abstract;

   overriding
   --  Ajuste le contenu après l'affectation.
   --  @param Clef
   --  La clef.
   procedure Adjust (Clef : in out Clef_56_Abs_T) is abstract;

private

   type Clef_56_Abs_T is abstract new Clef_Abstraite_T with null record;

end Des_P.Clef_P.Clef_56_Abs_P;
