using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Dynamic.Models
{
    public class Link
    {
        public int id { get; set; }
        public int source { get; set; }
        public int target { get; set; }
        public string type { get; set; }
    }
}