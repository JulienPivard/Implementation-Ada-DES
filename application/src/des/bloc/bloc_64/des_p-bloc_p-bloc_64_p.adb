package body Des_P.Bloc_P.Bloc_64_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize (Bloc : in out Bloc_64_T) is
      use Des_P.Bloc_P.Bloc_32_P;
      G, D : Bloc_32_T;
   begin
      Bloc.Decalage := 0;
      Bloc.Blocs_32 (Gauche + Bloc.Decalage) := G;
      Bloc.Blocs_32 (Droite + Bloc.Decalage) := D;
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize (Bloc : in out Bloc_64_T) is
   begin
      null;
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust (Bloc : in out Bloc_64_T) is
   begin
      null;
   end Adjust;

   ---------------------------------------------------------------------------
   procedure Intervertir_Blocs (Bloc : in out Bloc_64_T) is
   begin
      Bloc.Decalage := Decalage_T'Succ (Bloc.Decalage);
   end Intervertir_Blocs;

   ---------------------------------------------------------------------------
   procedure Ecrire_Bit
      (
         Bloc : in out Bloc_64_T;
         Position : Intervalle_Bloc_64_T;
         Bit : Bit_T
      )
   is
      use Des_P.Bloc_P.Bloc_32_P;
      G_Ou_D : Position_Bloc_T := Gauche;
      P : Intervalle_Bloc_64_T := Position;
      P_Dans_Intervalle_32 : Intervalle_Bloc_32_T;
      Limite : constant Intervalle_Bloc_64_T :=
         Intervalle_Bloc_64_T (Intervalle_Bloc_32_T'Last);
   begin
      if Position > Limite then
         G_Ou_D := Droite;
         P := P - Limite;
      end if;
      P_Dans_Intervalle_32 := Intervalle_Bloc_32_T (P);
      Ecrire_Bit (Bloc, G_Ou_D, P_Dans_Intervalle_32, Bit);
   end Ecrire_Bit;

   ---------------------------------------------------------------------------
   function Lire_Bit
      (
         Bloc : Bloc_64_T;
         Position : Intervalle_Bloc_64_T
      )
      return Bit_T
   is
      use Des_P.Bloc_P.Bloc_32_P;
      G_Ou_D : Position_Bloc_T := Gauche;
      P : Intervalle_Bloc_64_T := Position;
      P_Dans_Intervalle_32 : Intervalle_Bloc_32_T;
      Limite : constant Intervalle_Bloc_64_T :=
         Intervalle_Bloc_64_T (Intervalle_Bloc_32_T'Last);
   begin
      if Position > Limite then
         G_Ou_D := Droite;
         P := P - Limite;
      end if;
      P_Dans_Intervalle_32 := Intervalle_Bloc_32_T (P);
      return Lire_Bit (Bloc, G_Ou_D, P_Dans_Intervalle_32);
   end Lire_Bit;

   ---------------------------------------------------------------------------
   procedure Ecrire_Bit
      (
         Bloc : in out Bloc_64_T;
         Bloc_G_Ou_D : Position_Bloc_T;
         Position : Des_P.Bloc_P.Bloc_32_P.Intervalle_Bloc_32_T;
         Bit : Bit_T
      )
   is
   begin
      Bloc.Blocs_32 (Bloc_G_Ou_D + Bloc.Decalage).Ecrire_Bit (Position, Bit);
   end Ecrire_Bit;

   ---------------------------------------------------------------------------
   function Lire_Bit
      (
         Bloc : Bloc_64_T;
         Bloc_G_Ou_D : Position_Bloc_T;
         Position : Des_P.Bloc_P.Bloc_32_P.Intervalle_Bloc_32_T
      )
      return Bit_T
   is
   begin
      return Bloc.Blocs_32 (Bloc_G_Ou_D + Bloc.Decalage).Lire_Bit (Position);
   end Lire_Bit;

   ---------------------------------------------------------------------------
   procedure Ecrire_Bloc
      (
         Bloc : in out Bloc_64_T;
         Bloc_G_Ou_D : Position_Bloc_T;
         Bloc_32 : Des_P.Bloc_P.Bloc_32_P.Bloc_32_T
      )
   is
   begin
      Bloc.Blocs_32 (Bloc_G_Ou_D + Bloc.Decalage) := Bloc_32;
   end Ecrire_Bloc;

   ---------------------------------------------------------------------------
   function Lire_Bloc
      (
         Bloc : Bloc_64_T;
         Bloc_G_Ou_D : Position_Bloc_T
      )
      return Des_P.Bloc_P.Bloc_32_P.Bloc_32_T
   is
   begin
      return Bloc.Blocs_32 (Bloc_G_Ou_D + Bloc.Decalage);
   end Lire_Bloc;

   ---------------------------------------------------------------------------
   function "+" (Left : Position_Bloc_T; Right : Decalage_T)
      return Position_Bloc_T
   is
      Cote_Tmp : constant Decalage_T := Position_Bloc_T'Pos (Left);
      Cote_Apres_Decalage : constant Decalage_T := Cote_Tmp + Right;
   begin
      return Position_Bloc_T'Val (Cote_Apres_Decalage);
   end "+";

   ---------------------------------------------------------------------------
   function "+" (Left : Decalage_T; Right : Position_Bloc_T)
      return Position_Bloc_T
   is
      Cote_Tmp : constant Decalage_T := Position_Bloc_T'Pos (Right);
      Cote_Apres_Decalage : constant Decalage_T := Cote_Tmp + Left;
   begin
      return Position_Bloc_T'Val (Cote_Apres_Decalage);
   end "+";

end Des_P.Bloc_P.Bloc_64_P;
