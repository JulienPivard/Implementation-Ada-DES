with Des_P.Clef_P.Constructeur_48_Abs_P;
with Des_P.Clef_P.Constructeur_56_Abs_P;

--  @summary
--  La clef de 64 bits permettant de crypter les données.
--  @description
--  La représentation d'une clef de 64 bits, dans le standard DES.
--  @group Clef
package Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P is

   pragma Pure;

   use Des_P.Clef_P.Constructeur_48_Abs_P;
   use Des_P.Clef_P.Constructeur_56_Abs_P;

   --  La clef de 64 bits.
   type Clef_64_T is new Clef_64_Abs_T with private;

   overriding
   --  Indique si un constructeur de clef 56 bits à été attribué.
   --  @param Clef
   --  La clef de 64 bits.
   --  @return La clef possède un constructeur de clef 56 bits initialisé.
   function Possede_Constructeur_56 (Clef : Clef_64_T) return Boolean;

   overriding
   --  Indique si un constructeur de clef 48 bits à été attribué.
   --  Si la clef de 64 ne possède pas de clef 48, les clef de 56
   --  qui seront construite n'auront pas de constructeur de clef
   --  48.
   --  @param Clef
   --  La clef de 48 bits.
   --  @return La clef possède un constructeur de clef 48 bits initialisé.
   function Possede_Constructeur_48 (Clef : Clef_64_T) return Boolean;

   overriding
   --  Lit le bit à la position spécifié.
   --  @param Clef
   --  La clef dont on veut lire un bit.
   --  @param Position
   --  La position du bit que l'on veut lire.
   --  @return Le bit lu.
   function Lire_Bit
      (Clef : Clef_64_T; Position : Intervalle_Clef_64_T)
      return Bit_T;

   overriding
   --  Permet de généré une clef de 56 bits à partir de la clef de 64.
   --  @param Clef
   --  La clef de 64 bits.
   --  @return La clef de 56 bits.
   function Lire_Clef_56 (Clef : Clef_64_T)
      return Des_P.Clef_P.Clef_56_Abs_P.Clef_56_P.Clef_56_T;

   overriding
   --  Création d'une clef vide par défaut.
   --  @param Clef
   --  La clef.
   procedure Initialize (Clef : in out Clef_64_T);

   overriding
   --  Supprime la clef.
   --  @param Clef
   --  La clef.
   procedure Finalize (Clef : in out Clef_64_T);

   overriding
   --  Ajuste le contenu après l'affectation.
   --  @param Clef
   --  La clef.
   procedure Adjust (Clef : in out Clef_64_T);

private

   --  Tableau des bits de la clef. Un bit par case.
   --  Cette représentation à été choisie pour faciliter la
   --  construction depuis la forme brut des bits.
   type Tableau_Bits_T is array (Intervalle_Clef_64_T) of Bit_T
      with Size => 64, Pack;

   type Clef_64_T is new Clef_64_Abs_T with
      record
         Bits : Tableau_Bits_T;
         Constructeur_56 : access Constructeur_Clef_56_Abs_T'Class;
         Constructeur_48 : access Constructeur_Clef_48_Abs_T'Class;
      end record;

end Des_P.Clef_P.Clef_64_Abs_P.Clef_64_P;
