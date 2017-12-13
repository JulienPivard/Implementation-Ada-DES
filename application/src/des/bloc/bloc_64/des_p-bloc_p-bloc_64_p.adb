package body Des_P.Bloc_P.Bloc_64_P is

   ---------------------------------------------------------------------------
   overriding
   procedure Initialize (B : in out Bloc_64_T) is
      use Des_P.Bloc_P.Bloc_32_P;
      G, D : Bloc_32_T;
   begin
      B.Decalage := 0;
      B.Blocs_32 (B.Decalage) := G;
      B.Blocs_32 (B.Decalage + 1) := D;
   end Initialize;

   ---------------------------------------------------------------------------
   overriding
   procedure Finalize (B : in out Bloc_64_T) is
   begin
      null;
   end Finalize;

   ---------------------------------------------------------------------------
   overriding
   procedure Adjust (B : in out Bloc_64_T) is
   begin
      null;
   end Adjust;

   ---------------------------------------------------------------------------
   procedure Intervertir_Blocs (B : in out Bloc_64_T) is
   begin
      B.Decalage := Decalage_T'Succ (B.Decalage);
   end Intervertir_Blocs;

   ---------------------------------------------------------------------------
   procedure Ecrire_Bit
      (
         B : in out Bloc_64_T;
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
      Ecrire_Bit (B, G_Ou_D, P_Dans_Intervalle_32, Bit);
   end Ecrire_Bit;

   ---------------------------------------------------------------------------
   function Lire_Bit
      (
         B : Bloc_64_T;
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
      return Lire_Bit (B, G_Ou_D, P_Dans_Intervalle_32);
   end Lire_Bit;

   ---------------------------------------------------------------------------
   procedure Ecrire_Bit
      (
         B : in out Bloc_64_T;
         Bloc_G_Ou_D : Position_Bloc_T;
         Position : Des_P.Bloc_P.Bloc_32_P.Intervalle_Bloc_32_T;
         Bit : Bit_T
      )
   is
      Position_Bloc : Decalage_T := B.Decalage;
   begin
      if Bloc_G_Ou_D = Droite then
         Position_Bloc := Position_Bloc + 1;
      end if;
      B.Blocs_32 (Position_Bloc).Ecrire_Bit (Position, Bit);
   end Ecrire_Bit;

   ---------------------------------------------------------------------------
   function Lire_Bit
      (
         B : Bloc_64_T;
         Bloc_G_Ou_D : Position_Bloc_T;
         Position : Des_P.Bloc_P.Bloc_32_P.Intervalle_Bloc_32_T
      )
      return Bit_T
   is
      Position_Bloc : Decalage_T := B.Decalage;
   begin
      if Bloc_G_Ou_D = Droite then
         Position_Bloc := Position_Bloc + 1;
      end if;
      return B.Blocs_32 (Position_Bloc).Lire_Bit (Position);
   end Lire_Bit;

end Des_P.Bloc_P.Bloc_64_P;
