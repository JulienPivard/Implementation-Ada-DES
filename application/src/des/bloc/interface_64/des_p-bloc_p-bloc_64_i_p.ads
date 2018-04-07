package Des_P.Bloc_P.Bloc_64_I_P is

   pragma Pure;

   type Intervalle_T is range 1 .. 64;
   --  L'intervalle pour accéder aux bits du bloc de 64 bits.

   type Bloc_Interface_T is interface;
   --  Une interface bloc de 64 bits

   type Position_Bloc_T is (Gauche, Droite);
   --  Désigne le bloc de 32 bits de gauche ou le bloc de droite.
   --  @value Gauche
   --  Le bloc de 32 bits de gauche.
   --  @value Droite
   --  Le bloc de 32 bits de droite.

   procedure Intervertir_Blocs
      (Bloc : in out Bloc_Interface_T)
   is abstract;
   --  Fait passer le bloc de 32 bits de gauche à droite et
   --  le bloc de 32 bits de droite à gauche. L'ordre des bits
   --  à l'intérieur des bloc de 32 n'est bien entendu pas modifié.
   --  @param Bloc
   --  Le bloc de 64 bits.

   procedure Ecrire_Bit
      (
         Bloc : in out Bloc_Interface_T;
         Position : Intervalle_T;
         Bit : Bit_T
      )
   is abstract;
   --  Écrit le bit à la position demandé dans le bloc de 64.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @param Position
   --  La position du bit qu'on veut écrire.
   --  @param Bit
   --  Le bit qu'on veut écrire.

   function Lire_Bit
      (
         Bloc : Bloc_Interface_T;
         Position : Intervalle_T
      )
      return Bit_T
   is abstract;
   --  Lit le bit demandé dans le bloc de 64.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @param Position
   --  La position du bit qu'on veut lire.
   --  @return Le bit demandé.

   procedure Ecrire_Bit
      (
         Bloc : in out Bloc_Interface_T;
         Bloc_G_Ou_D : Position_Bloc_T;
         Position : Des_P.Bloc_P.Bloc_32_P.Intervalle_T;
         Bit : Bit_T
      )
   is abstract;
   --  Écrit le bit à la position demandé dans le bloc
   --  gauche ou droite de 32 bits du bloc de 64.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @param Bloc_G_Ou_D
   --  Désigne le bloc gauche ou droite à écrire.
   --  @param Position
   --  La position du bit qu'on veut écrire dans le bloc gauche.
   --  @param Bit
   --  Le bit qu'on veut écrire.

   function Lire_Bit
      (
         Bloc : Bloc_Interface_T;
         Bloc_G_Ou_D : Position_Bloc_T;
         Position : Des_P.Bloc_P.Bloc_32_P.Intervalle_T
      )
      return Bit_T
   is abstract;
   --  Lit le bit à la position demandé dans le bloc
   --  de 32 bits, gauche ou droit, du bloc de 64.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @param Bloc_G_Ou_D
   --  Désigne le bloc gauche ou droite à lire.
   --  @param Position
   --  La position du bit qu'on veut lire dans le bloc gauche ou droit.
   --  @return Le bit lu.

   procedure Ecrire_Bloc
      (
         Bloc : in out Bloc_Interface_T;
         Bloc_G_Ou_D : Position_Bloc_T;
         Bloc_32 : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T
      )
   is abstract;
   --  Écrit le bloc de 32 bits à droite ou à gauche dans le
   --  bloc de 64 bits.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @param Bloc_G_Ou_D
   --  Désigne le bloc gauche ou droite à écrire.
   --  @param Bloc_32
   --  Le bloc de 32 bits.

   function Lire_Bloc
      (
         Bloc : Bloc_Interface_T;
         Bloc_G_Ou_D : Position_Bloc_T
      )
      return Des_P.Bloc_P.Bloc_32_P.Bloc_32_T
   is abstract;
   --  Permet de lire le bloc de 32 bits de gauche ou de droite.
   --  @param Bloc
   --  Le bloc de 64 bits.
   --  @param Bloc_G_Ou_D
   --  Désigne le bloc de 32 bits de droite ou de gauche.
   --  @return Le bloc de 32 bits qui à été désigné.

end Des_P.Bloc_P.Bloc_64_I_P;
