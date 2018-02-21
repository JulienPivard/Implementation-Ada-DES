package body Des_P.Filtre_P.Corps_P.Corps_Decryptage_P.Lecteur_P is

   ---------------------------------------------------------------------------
   function Lire_Numero_Filtre (Filtre : Corps_T) return Numero_Filtre_T is
   begin
      return Filtre.Numero;
   end Lire_Numero_Filtre;

end Des_P.Filtre_P.Corps_P.Corps_Decryptage_P.Lecteur_P;
