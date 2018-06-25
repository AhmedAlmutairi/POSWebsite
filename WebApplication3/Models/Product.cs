namespace WebApplication3.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
    using System.Web;

    [Table("Product")]
    public partial class Product
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Product()
        {
            OrderProducts = new HashSet<OrderProduct>();
        }

        public int Id { get; set; }

        public int SubCatId { get; set; }

        [Required]
        [StringLength(256)]
        public string Name { get; set; }

        public decimal Price { get; set; }

        public decimal Quantity { get; set; }

        [StringLength(500)]
        public string Other { get; set; }

        [StringLength(500)]
        public string Description { get; set; }

        [Required]
        public byte[] Image { get; set; }

        [StringLength(25)]
        public string BarCode { get; set; }

        

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderProduct> OrderProducts { get; set; }
        public virtual SubCategory SubCategory { get; set; }
        

    }
}
