with Des_P.Bloc_P.Bloc_32_P;

--  @summary
--  Interface de constructeur de bloc de 48 bits.
--  @description
--  Construit le bloc de 48 bits à partir d'un bloc brut.
--  @group Bloc Constructeur
package Des_P.Bloc_P.Bloc_48_I_P.Faiseur_I_P is

   pragma Pure;

   type Faiseur_Interface_T is interface;
   --  Constructeur de blocs de 48 bits.

   procedure Preparer_Nouveau_Bloc
      (Constructeur : in out Faiseur_Interface_T)
   is abstract;
   --  Initialise un nouveau bloc vide de 48 bits.
   --  @param Constructeur
   --  Le constructeur de bloc de 48 bits.

   procedure Construire_Bloc
      (
         Constructeur : in out Faiseur_Interface_T;
         Brut : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T
      )
   is abstract;
   --  Construit le bloc de 48 bits en étendant un bloc de 32 bits.
   --  @param Constructeur
   --  Le constructeur de bloc de 48 bits.
   --  @param Brut
   --  Le bloc de 32 bits.

   function Recuperer_Bloc
      (Constructeur : Faiseur_Interface_T)
      return Bloc_Interface_T'Class
   is abstract;
   --  Récupère le bloc de 48 bits terminé.
   --  @param Constructeur
   --  Le constructeur de bloc de 48 bits.
   --  @return Le bloc de 48 bits.

end Des_P.Bloc_P.Bloc_48_I_P.Faiseur_I_P;
