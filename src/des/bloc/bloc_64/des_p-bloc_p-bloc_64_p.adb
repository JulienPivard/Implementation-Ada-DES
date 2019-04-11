package body Des_P.Bloc_P.Bloc_64_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize
      (Bloc : in out Bloc_64_T)
   is
      --  Deux bloc de 32 bits vide.
      G, D : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T;
   begin
      --  Remise à zéro du décalage.
      Bloc.Decalage                          := 0;
      Bloc.Blocs_32 (Gauche + Bloc.Decalage) := G;
      Bloc.Blocs_32 (Droite + Bloc.Decalage) := D;
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize
      (Bloc : in out Bloc_64_T)
   is
   begin
      null;
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust
      (Bloc : in out Bloc_64_T)
   is
   begin
      null;
   end Adjust;

   ---------------------------------------------------------------------------
   procedure Intervertir_Blocs
      (Bloc : in out Bloc_64_T)
   is
   begin
      --  Décale les blocs.
      Bloc.Decalage := Decalage_T'Succ (Bloc.Decalage);
   end Intervertir_Blocs;

   ---------------------------------------------------------------------------
   procedure Ecrire_Bit
      (
         Bloc     : in out Bloc_64_T;
         Position : Intervalle_T;
         Bit      : Bit_T
      )
   is
      --  Le bit demandé est à gauche par défaut.
      G_Ou_D : Position_Bloc_T := Gauche;
      P : Intervalle_T := Position;
      --  La position dans l'intervalle de 32 bits.
      P_Dans_Intervalle_32 : Des_P.Bloc_P.Bloc_32_P.Intervalle_T;
      --  La valeur maximal de l'intervalle de 32 bits.
      Limite : constant Intervalle_T :=
         Intervalle_T (Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Last);
   begin
      --  Si la position demandé est supérieur à la position
      --  maximal d'un bloc de 32 on manipule la valeur pour
      --  la ramener dans l'intervalle et on retient que le
      --  bit demandé est dans le bloc de droite.
      if Position > Limite then
         G_Ou_D := Droite;
         P := P - Limite;
      end if;
      --  Conversion de la position de l'intervalle 64 bits
      --  vers l'intervalle des blocs de 32 bits.
      P_Dans_Intervalle_32 := Des_P.Bloc_P.Bloc_32_P.Intervalle_T (P);
      --  On écrit le bits dans le bloc déterminé.
      --  La prise en compte du décalage se fait
      --  directement dans la méthode appelé.
      Ecrire_Bit
         (
            Bloc        => Bloc,
            Bloc_G_Ou_D => G_Ou_D,
            Position    => P_Dans_Intervalle_32,
            Bit         => Bit
         );
   end Ecrire_Bit;

   ---------------------------------------------------------------------------
   function Lire_Bit
      (
         Bloc     : Bloc_64_T;
         Position : Intervalle_T
      )
      return Bit_T
   is
      --  Le bit demandé est à gauche par défaut.
      G_Ou_D : Position_Bloc_T := Gauche;
      P : Intervalle_T := Position;
      --  La position dans l'intervalle de 32 bits.
      P_Dans_Intervalle_32 : Des_P.Bloc_P.Bloc_32_P.Intervalle_T;
      --  La valeur maximal de l'intervalle de 32 bits.
      Limite : constant Intervalle_T :=
         Intervalle_T (Des_P.Bloc_P.Bloc_32_P.Intervalle_T'Last);
   begin
      --  Si la position demandé est supérieur à la position
      --  maximal des blocs de 32 on manipule la valeur pour
      --  la ramener dans l'intervalle et on retient que le
      --  bit demandé est dans le bloc de droite.
      if Position > Limite then
         G_Ou_D   := Droite;
         P        := P - Limite;
      end if;
      --  Conversion de la position de l'intervalle 64 bits
      --  vers l'intervalle des blocs de 32 bits.
      P_Dans_Intervalle_32 := Des_P.Bloc_P.Bloc_32_P.Intervalle_T (P);
      --  On lit le bits dans le bloc déterminé.
      --  La prise en compte du décalage se fait
      --  directement dans la méthode appelé.
      return Lire_Bit
         (
            Bloc         => Bloc,
            Bloc_G_Ou_D  => G_Ou_D,
            Position     => P_Dans_Intervalle_32
         );
   end Lire_Bit;

   ---------------------------------------------------------------------------
   procedure Ecrire_Bit
      (
         Bloc        : in out Bloc_64_T;
         Bloc_G_Ou_D : Position_Bloc_T;
         Position    : Des_P.Bloc_P.Bloc_32_P.Intervalle_T;
         Bit         : Bit_T
      )
   is
   begin
      --  Écrit directement le bit dans le bloc
      --  en tenant compte du décalage.
      Bloc.Blocs_32 (Bloc_G_Ou_D + Bloc.Decalage).Ecrire_Bit
         (
            Position  => Position,
            Bit       => Bit
         );
   end Ecrire_Bit;

   ---------------------------------------------------------------------------
   function Lire_Bit
      (
         Bloc        : Bloc_64_T;
         Bloc_G_Ou_D : Position_Bloc_T;
         Position    : Des_P.Bloc_P.Bloc_32_P.Intervalle_T
      )
      return Bit_T
   is
   begin
      --  Lit directement le bit dans le bloc
      --  en tenant compte du décalage.
      return Bloc.Blocs_32 (Bloc_G_Ou_D + Bloc.Decalage).Lire_Bit
         (Position => Position);
   end Lire_Bit;

   ---------------------------------------------------------------------------
   procedure Ecrire_Bloc
      (
         Bloc        : in out Bloc_64_T;
         Bloc_G_Ou_D : Position_Bloc_T;
         Bloc_32     : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T
      )
   is
   begin
      --  Remplace le bloc gauche ou droit par le bloc donné.
      Bloc.Blocs_32 (Bloc_G_Ou_D + Bloc.Decalage) := Bloc_32;
   end Ecrire_Bloc;

   ---------------------------------------------------------------------------
   function Lire_Bloc
      (
         Bloc        : Bloc_64_T;
         Bloc_G_Ou_D : Position_Bloc_T
      )
      return Des_P.Bloc_P.Bloc_32_P.Bloc_32_T
   is
   begin
      --  Lit le bloc demandé.
      return Bloc.Blocs_32 (Bloc_G_Ou_D + Bloc.Decalage);
   end Lire_Bloc;

   ---------------------------------------------------------------------------
   function "+"
      (
         Left  : Position_Bloc_T;
         Right : Decalage_T
      )
      return Position_Bloc_T
   is
      --  Convertit la position (G ou D) en une valeur numérique.
      Cote_Tmp             : constant Decalage_T :=
         Position_Bloc_T'Pos (Left);
      --  Addition de la valeur de la position avec le décalage.
      Cote_Apres_Decalage  : constant Decalage_T :=
         Cote_Tmp + Right;
   begin
      --  Conversion de la valeur obtenue en position G ou D.
      return Position_Bloc_T'Val (Cote_Apres_Decalage);
   end "+";

   ---------------------------------------------------------------------------
   function "+"
      (
         Left  : Decalage_T;
         Right : Position_Bloc_T
      )
      return Position_Bloc_T
   is
   begin
      return Right + Left;
   end "+";

end Des_P.Bloc_P.Bloc_64_P;
