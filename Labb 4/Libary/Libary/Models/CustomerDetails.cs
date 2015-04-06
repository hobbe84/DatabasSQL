using System;
using System.Collections.Generic;
using System.Linq;
using Libary.DataAccess;
using System.Web;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Libary.Models
{
    public class CustomerDetails
    {
        [DisplayName("Allowed to Loan")]
        public bool EntitledForLoan { get; set; }
        public int CustomerID { get; set; }
        [DisplayName("Customer Name")]
        public string CustomerName { get; set; }
        [DisplayName("StreetAddress")]
        public string Address { get; set; }
        [DisplayName("Phone Number")]
        public string PhoneNumber { get; set; }
        [DisplayName("Email Address")]
        public string EmailAddress { get; set; }
        public string Gender { get; set; }
        [DisplayName("Birth Date")]
        public DateTime? BirthDate { get; set; }
        [DisplayName("Loans Overdue")]
        public bool LoansOverDue { get; set; } 
        public string Author { get; set; }
        [DisplayName("Books Loaned")]
        public bool Loans { get; set; }
        [DisplayName("Books on Loan")]
        public List<Loans> ActiveLoans { get; set; }
        [DisplayName("Make a new Loan")]
        [Display(Prompt = "Enter CopyID")]   // funkar inte 
        public int? BorrowBook { get; set; }
    }

    public class Loans
    {
        [DisplayName("Litterature Title")]
        public string LitteratureTitle { get; set; }
        public int LitteratureCopyID { get; set; }
        public string ISBN { get; set; }
        [DisplayName("Loans Overdue")]
        public bool LoansOverDue { get; set; }
        [DisplayName("Borrow Date")]
        public DateTime? BorrowDate { get; set; }
        [DisplayName("Return Date")]
        public DateTime? ReturnDate { get; set; }

        public List<Loans> LoansOnCustomers(int? customerId)
        {
            List<Loans> activeLoans;
            using (var ctx = new LibaryEntities())
            {
                if (!customerId.HasValue)
                {
                    throw new ArgumentNullException();
                }
                var loansoverdue = ctx.LitteratureLoans.Any(x => x.CustomerID == customerId.Value && x.Returndate < DateTime.Now && !x.LoanReturned);
                var query =
                     (from c in ctx.Customers
                      join ll in ctx.LitteratureLoans on c.ID equals ll.CustomerID
                      join lc in ctx.LitteratureCopies on ll.LitteratureCopyID equals lc.ID
                      join l in ctx.Litteratures on lc.LitteratureID equals l.ID
                      where !ll.LoanReturned && c.ID == customerId
                      select new Loans
                      {
                          LitteratureCopyID = lc.ID, 
                          LitteratureTitle = l.Title,
                          ISBN = l.ISBN,
                          BorrowDate = ll.BorrowDate,
                          ReturnDate = ll.Returndate,
                          LoansOverDue = loansoverdue && lc.StatusID == 3
                      })
                     .ToList();
                activeLoans = query;
            }
            return activeLoans;
        }
    }
}