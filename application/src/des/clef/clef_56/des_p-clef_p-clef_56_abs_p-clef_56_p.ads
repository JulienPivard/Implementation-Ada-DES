with Des_P.Clef_P.Constructeur_48_Abs_P;

--  @summary
--  La clef de 56 bits permettant de crypter les données.
--  @description
--  La représentation d'une clef de 56 bits, construite à partir d'une
--  clef de 64 bits. Le constructeur se charge de sélectionner les bits.
--  @group Clef
package Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P is

   pragma Pure;
   use Des_P.Clef_P.Constructeur_48_Abs_P;

   --  La clef de 56 bits.
   type Clef_56_T is new Clef_56_Abs_T with private;

   --  Modifie le constructeur de clef de 48 bits.
   --  @param Clef
   --  La clef à modifier.
   --  @param Constructeur_Clef_48
   --  Le constructeur de clef de 48 bits.
   procedure Ecrire_Constructeur
   (
      Clef : out Clef_56_T;
      Constructeur_Clef_48 : access Constructeur_Clef_48_Abs_T'Class
   );

   overriding
   --  Décale les bits de la clef vers la gauche
   --  @param Clef
   --  La clef dont on veut décaler les bits.
   --  @param Nb_Decalage
   --  Le nombre de décalages vers la gauche. Par défaut 1.
   procedure Decaler_Bits_A_Gauche
      (Clef : in out Clef_56_T; Nb_Decalage : Decalage_T := 1);

   overriding
   --  Lit un bit spécifié.
   --  @param Clef
   --  La clef dont on veut lire un bit.
   --  @param Position
   --  La position du bit que l'on veut lire.
   --  @return Le bit lu.
   function Lire_Bit
      (Clef : Clef_56_T; Position : Intervalle_Clef_56_T)
      return Bit_T;

   overriding
   --  Permet de générer une sous clef. Cette clef est construite
   --  grâce au décalage PC-2 décrit dans le standard DES.
   --  @param Clef
   --  La clef de 56 bits.
   --  @return La sous clef de 48 bits.
   function Lire_Clef_48 (Clef : Clef_56_T)
      return Des_P.Clef_P.Clef_48_Abs_P.Clef_48_P.Clef_48_T;

   overriding
   --  Création d'une clef vide par défaut.
   --  @param Clef
   --  La clef.
   procedure Initialize (Clef : in out Clef_56_T);

   overriding
   --  Supprime la clef.
   --  @param Clef
   --  La clef.
   procedure Finalize (Clef : in out Clef_56_T);

   overriding
   --  Ajuste le contenu après l'affectation.
   --  @param Clef
   --  La clef.
   procedure Adjust (Clef : in out Clef_56_T);

private

   --  L'intervalle des demi tableau de bits de la clef.
   subtype Intervalle_Demi_Clef_T is Decalage_T;

   --  Tableau des bits de la clef. Intervalle de 0 à 27
   type Champ_De_Bits_T is array
      (Intervalle_Demi_Clef_T range Intervalle_Demi_Clef_T'Range) of Bit_T;

   type Clef_56_T is new Clef_56_Abs_T with
      record
         Decalage : Decalage_T;
         C1 : Champ_De_Bits_T;
         C2 : Champ_De_Bits_T;
         Constructeur : access Constructeur_Clef_48_Abs_T'Class;
      end record;

end Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P;
