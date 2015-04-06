using System;
using System.Collections.Generic;
using System.Linq;
using Libary.DataAccess;
using System.Web;
using System.ComponentModel;

namespace Libary.Models
{
    public class CustomerSummary
    {
        [DisplayName("Allowed to Loan")]
        public bool EntitledForLoan { get; set; }
        public int CustomerID { get; set; }
        [DisplayName("Customer Name")]
        public string CustomerName { get; set; }
        [DisplayName("Streetaddress")]
        public string Address { get; set; }
        [DisplayName("Phonenumber")]
        public string PhoneNumber { get; set; }
        [DisplayName("Emailaddress")]
        public string EmailAddress { get; set; }
        public string Gender { get; set; }
        [DisplayName("Birth Date")]
        public DateTime? BirthDate { get; set; }
        [DisplayName("No of Active Loans")]
        public int LitteratureLoans { get; set; }
        [DisplayName("Books Overdue")]
        public int LoansOverDue { get; set; }
        [DisplayName("Active Loans")]
        public bool ActiveLoans { get; set; }
    }
}