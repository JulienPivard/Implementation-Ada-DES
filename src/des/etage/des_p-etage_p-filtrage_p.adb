package body Des_P.Etage_P.Filtrage_P is

   ---------------------------------------------------------------------------
   function Construire_Etage_Sans_Successeur
      return Etage_T
   is
      Etage : Etage_T;
   begin
      Etage.Filtre := Des_P.Filtre_P.Holder_P.Empty_Holder;
      return Etage;
   end Construire_Etage_Sans_Successeur;

   ---------------------------------------------------------------------------
   function Construire_Etage_Avec_Successeur
      (Successeur : Etage_Abstrait_T'Class)
      return Etage_T
   is
      Etage : Etage_T;
   begin
      Etage.Filtre := Des_P.Filtre_P.Holder_P.Empty_Holder;
      Etage.Modifier_Successeur (Successeur => Successeur);
      return Etage;
   end Construire_Etage_Avec_Successeur;

   ---------------------------------------------------------------------------
   overriding
   function Possede_Filtre
      (Etage : Etage_T)
      return Boolean
   is
   begin
      return not Etage.Filtre.Is_Empty;
   end Possede_Filtre;

   ---------------------------------------------------------------------------
   overriding
   function Possede_Successeur
      (Etage : Etage_T)
      return Boolean
   is
   begin
      return not Etage.Successeur.Is_Empty;
   end Possede_Successeur;

   ---------------------------------------------------------------------------
   overriding
   procedure Ajouter_Successeur
      (
         Etage       : in out Etage_T;
         Successeur  : Etage_Abstrait_T'Class
      )
   is
   begin
      --  Si l'étage possède un successeur on ajoute le successeur
      --  au successeur de cet étage.
      if Etage.Possede_Successeur then
         Etage.Successeur.Reference.Ajouter_Successeur
            (Successeur => Successeur);
      else
         Etage.Modifier_Successeur (Successeur => Successeur);
      end if;
   end Ajouter_Successeur;

   ---------------------------------------------------------------------------
   overriding
   procedure Modifier_Successeur
      (
         Etage       : in out Etage_T;
         Successeur  : Etage_Abstrait_T'Class
      )
   is
   begin
      Etage.Successeur := Holder_P.To_Holder (New_Item => Successeur);
   end Modifier_Successeur;

   ---------------------------------------------------------------------------
   overriding
   procedure Modifier_Filtre
      (
         Etage    : in out Etage_T;
         Filtre   : Des_P.Filtre_P.Filtre_Interface_T'Class
      )
   is
   begin
      Etage.Filtre := Des_P.Filtre_P.Holder_P.To_Holder (New_Item => Filtre);
   end Modifier_Filtre;

   ---------------------------------------------------------------------------
   overriding
   procedure Iterer
      (
         Etage : Etage_T;
         Bloc  : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
      )
   is
   begin
      --  Si l'étage possède un successeur on transmet le bloc au
      --  successeur pour le filtrer.
      Etage.Filtrer (Bloc => Bloc);
      if Etage.Possede_Successeur then
         Etage.Successeur.Element.Iterer (Bloc => Bloc);
      end if;
   end Iterer;

   ---------------------------------------------------------------------------
   --                               Partie privée                           --
   ---------------------------------------------------------------------------
   procedure Filtrer
      (
         Etage : Etage_T;
         Bloc  : in out Des_P.Bloc_P.Bloc_64_P.Bloc_64_T
      )
   is
   begin
      if not Possede_Filtre (Etage => Etage) then
         raise Pas_De_Filtre_E;
      end if;
      Etage.Filtre.Element.Filtrer (Bloc => Bloc);
   end Filtrer;

end Des_P.Etage_P.Filtrage_P;
