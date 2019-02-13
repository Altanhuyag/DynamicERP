using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Dynamic.Models
{
    public class Task
    {
        public int id { get; set; }
        public string text { get; set; }
        public DateTime start_date { get; set; }
        public int duration { get; set; }
        public double progress { get; set; }
        public int parent { get; set; }
    }
}