using Libary.DataAccess;
using Libary.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Core.Objects;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace Libary.Controllers
{
    public class CustomerController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            IList<CustomerSummary> customers;

            using (var ctx = new LibaryEntities())
            {
                var query =
                  from c in ctx.Customers
                  join ll in ctx.LitteratureLoans on c.ID equals ll.CustomerID
                  where ll.Returndate > DateTime.Now || !ll.LoanReturned
                  group c by c.ID into grp
                  select new { CustomerID = grp.Key, Count = grp.Count() };

                var nextQuery =
                    from ll in ctx.LitteratureLoans
                    join c in ctx.Customers on ll.CustomerID equals c.ID
                    where ll.Returndate < DateTime.Now && !ll.LoanReturned
                    group ll by c.ID into grp
                    select new { LoanID = grp.Key, Count = grp.Count() };


                customers =
                    (from c in ctx.Customers
                     join q in query on c.ID equals q.CustomerID into qs
                     join nq in nextQuery on c.ID equals nq.LoanID into nqs
                     from q in qs.DefaultIfEmpty()
                     from nq in nqs.DefaultIfEmpty()
                     where c.ActiveCustomer == true
                     select new CustomerSummary
                     {
                         EntitledForLoan = c.EntitledForLoan,
                         CustomerID = c.ID,
                         CustomerName = c.FirstName + " " + c.LastName,
                         Address = c.Address,
                         EmailAddress = c.EmailAddress,
                         PhoneNumber = c.PhoneNumber,
                         LitteratureLoans = q == null ? 0 : q.Count,
                         LoansOverDue = nq == null ? 0 : nq.Count
                     }).ToList();

            }
            return View(customers);
        }

        // GET: CustomerDetails
        [HttpGet]
        public ActionResult Customer(int? id)
        {            
            if (!id.HasValue)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CustomerDetails customer;
            using (var ctx = new LibaryEntities())
            {
                var loans = ctx.LitteratureLoans.Any(x => x.CustomerID == id.Value && !x.LoanReturned);

                var query =
                    (from c in ctx.Customers
                    where c.ID == id
                    select new CustomerDetails
                    {
                        CustomerID = c.ID,
                        CustomerName = c.FirstName + " " + c.LastName,
                        Address = c.Address,
                        EmailAddress = c.EmailAddress,
                        PhoneNumber = c.PhoneNumber,
                        Gender = c.Gender,
                        BirthDate = c.BirthDate,
                        EntitledForLoan = c.EntitledForLoan,
                        Loans = loans                        
                    }).FirstOrDefault();

                customer = query;                
            }
            var Loan = new Loans();
            customer.ActiveLoans = Loan.LoansOnCustomers(id);        
            
            if (customer == null)
            {
                return HttpNotFound();
            }
            return View(customer);
        }
        [HttpGet]
        public ActionResult ReturnBook(int? id, int? cid)
        {
            // TODO: fixa skiten så att han inte smäller vid retur
            if (!id.HasValue)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            if (!cid.HasValue)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            using (var ctx = new LibaryEntities())
            {
                ctx.uspReturnBook(id);
            } 
            return RedirectToAction("Customer", new { id = cid });
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult BorrowBook(int? BookID, int? cID)
        {
            using (var ctx = new LibaryEntities())
            {
                ctx.uspBorrowBook(cID, BookID);
            }
            return RedirectToAction("Customer", new { id = cID });
        }
        [HttpGet]
        public ActionResult DeleteCustomer(int? id)
        {
            if (!id.HasValue)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CustomerSummary customer;
            using (var ctx = new LibaryEntities())
            {
                var activeLoans = ctx.LitteratureLoans.Any(x => x.CustomerID == id.Value);

                var query =
                    from c in ctx.Customers
                    where c.ID == id
                    select new CustomerSummary
                    {
                        CustomerID = c.ID,
                        CustomerName = c.FirstName + " " + c.LastName,
                        Address = c.Address,
                        EmailAddress = c.EmailAddress,
                        PhoneNumber = c.PhoneNumber,
                        ActiveLoans = activeLoans
                    };
                customer = query.FirstOrDefault();
            }
            if (customer == null)
            {
                return HttpNotFound();
            }

            return View(customer);
        }
        [HttpPost, ActionName("DeleteCustomer")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {            
            try
            {
                using (var ctx = new LibaryEntities())
                {
                    var query =
                        from c in ctx.Customers
                        where c.ID == id
                        select c;

                    foreach (var c in query)
                    {
                        c.ActiveCustomer = false;
                    }

                    try
                    {
                        ctx.SaveChanges();
                    }
                    catch (Exception)
                    {
                        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                    }
                }
            }
            catch (Exception)
            {

                return RedirectToAction("DeleteCustomer", new { id = id });
            }
            return RedirectToAction("Index");
        }
    }
}