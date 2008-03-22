function random_logo_name(max,prefix,suffix)
{
   var rand_no = Math.floor((max+1) * Math.random())
   return prefix + rand_no + suffix
}

function insert_random_logo_for_id(s,prefix,suffix,max)
{
   var img = document.getElementById(s)
   if (img)
   {
      img.src = random_logo_name(max,prefix,suffix);
   }
}

