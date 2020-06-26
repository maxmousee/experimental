const restaurantBill = (bill) => {
    const tax = 0.1
    var total_with_tax = bill * (1 + tax)
    var per_person = total_with_tax / 5
    return "$" + per_person.toFixed(2)
}

var the_bill = restaurantBill(50)
console.log(the_bill);
