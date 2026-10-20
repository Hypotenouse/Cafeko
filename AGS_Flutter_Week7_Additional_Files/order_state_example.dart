// In your MenuScreen (or wherever your list is):

// 1. Declare the list at the top of your state class
// List<Map<String, dynamic>> cartItems = [];

// 2. Wrap your push navigation in an async function to await the result
/*
Future<void> _navigateAndAddOrder(BuildContext context) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddOrderScreen()),
  );

  // 3. Check if we got data back, and if so, use setState to update the list
  if (result != null) {
    setState(() {
      cartItems.add(result);
    });
  }
}
*/
