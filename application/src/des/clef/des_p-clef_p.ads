with Ada.Finalization;

with Des_P.Sous_Clef_P;

--  @summary
--  La clef permettant de crypter les données.
--  @description
--  La représentation d'une clef. Construite à partir d'une clef de 64 bits,
--  celle-ci n'en compte que 56 sélectionné par le constructeur.
--  @group Clef
package Des_P.Clef_P is

   pragma Pure;

   --  Un bit de la clef.
   type Bit_T is range 0 .. 1;

   --  La clef de 56 bits.
   type Clef_T is new Ada.Finalization.Controlled with private;

   --  L'intervalle de bit qui est contenu dans la clef.
   type Intervalle_Clef_T is range 1 .. 56;

   --  Modifie le constructeur utilisé pour construire la sous clef.
   --  @param Clef
   --  La clef de 56 bits.
   --  @param Constructeur
   --  Le constructeur de la sous clef.
   --  procedure Modifier_Constructeur_Sous_Clef
   --     (Clef : in out Clef_T; Constructeur : Constructeur_Sous_Clef_T);

   overriding
   --  Création d'une clef vide par défaut.
   --  @param Clef
   --  La clef de 56 bits.
   procedure Initialize (Clef : in out Clef_T);

   overriding
   --  Supprime la clef.
   --  @param Clef
   --  La clef de 56 bits.
   procedure Finalize (Clef : in out Clef_T);

   overriding
   --  Ajuste le contenu après l'affectation.
   --  @param Clef
   --  La clef de 56 bits.
   procedure Adjust (Clef : in out Clef_T);

   --  Décale les bits de la clef vers la gauche
   --  @param Clef
   --  La clef dont on veut décaler les bits.
   --  @param Nb_Decalage
   --  Le nombre de décalages vers la gauche. Par défaut 1.
   procedure Decaler_Bits_A_Gauche
      (Clef : in out Clef_T; Nb_Decalage : Natural := 1);

   --  Lit un bit spécifié.
   --  @param Clef
   --  La clef dont on veut lire un bit.
   --  @param Position
   --  La position du bit que l'on veut lire.
   --  @return Le bit lu.
   function Lire_Bit
      (Clef : Clef_T; Position : Intervalle_Clef_T)
      return Bit_T;

   --  Permet de générer une sous clef. Cette clef est construite
   --  grâce au décalage PC-2 décrit dans le standard DES.
   --  @param Clef
   --  La clef de 56 bits.
   --  @return La sous clef de 48 bits.
   function Lire_Clef (Clef : Clef_T) return Des_P.Sous_Clef_P.Sous_Clef_T;

private

   --  Le décalage des bits de la clef.
   subtype Decalage_T is Natural;

   --  L'intervalle des demi tableau de bits de la clef.
   type Intervalle_Demi_Clef_T is mod 28;

   --  Tableau des bits de la clef. Intervalle de 0 à 27
   type Champ_De_Bits_T is array
      (Intervalle_Demi_Clef_T range Intervalle_Demi_Clef_T'Range) of Bit_T;

   type Clef_T is new Ada.Finalization.Controlled with
      record
         Decalage : Decalage_T;
         C1 : Champ_De_Bits_T;
         C2 : Champ_De_Bits_T;
      end record;

end Des_P.Clef_P;
