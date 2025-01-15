import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ClientAdapter());
  await Hive.openBox<Client>('clients');
  runApp(MyApp());
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   Hive.registerAdapter(ClientAdapter());
//   await Hive.deleteBoxFromDisk('clients'); // Clear previous data
//   await Hive.openBox<Client>('clients');
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Client Manager',
      theme: ThemeData(colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: ClientListPage(),
    );
  }
}

class ClientListPage extends StatefulWidget {
  @override
  _ClientListPageState createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {
  final Box<Client> _clientBox = Hive.box<Client>('clients');

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
        child: SafeArea(
          child:Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Client Manager',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontStyle:FontStyle.italic ,
                    fontWeight: FontWeight.w800,
                ),
              ),
              backgroundColor: Colors.red,
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.list), text: 'Clients'),
                  Tab(icon: Icon(Icons.add), text: 'Add Client'),
                  Tab(icon: Icon(Icons.edit), text: 'Edit Client'),
                ],
                isScrollable: true,
                labelColor: Colors.white,
              ),
            ),
            body: TabBarView(
              children: [
                ClientListView(clientBox: _clientBox),
                AddClientPage(),
                EditClientPage(clientBox: _clientBox),
              ],
            ),
        ),
      ),
    );
  }
}

// Displays the list of clients
class ClientListView extends StatelessWidget {
  final Box<Client> clientBox;

  ClientListView({required this.clientBox});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Client>>(
      valueListenable: clientBox.listenable(),
      builder: (context, box, _) {
        final clients = box.values.toList();
        return clients.isEmpty ? const Center(child: Text('No clients added yet.',style: TextStyle(fontSize: 40),)) : ListView.builder(
          itemCount: clients.length,
          itemBuilder: (context, index) {
            Client client = clients[index];
            return Card(
              elevation: 20,shadowColor: Colors.black,
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(client.name),
                subtitle: Text(
                  'Phone: ${client.phoneNumber}\n'
                      'Email: ${client.email}\n'
                      'Expire Date: ${client.expirationDate.toLocal().toString().split(' ')[0]}',
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// Page for adding a new client
class AddClientPage extends StatelessWidget {

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  DateTime _expirationDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  void _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _expirationDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _expirationDate) {
      _expirationDate = pickedDate;
    }
  }

  void _addClient(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final phoneNumber = int.tryParse(_phoneController.text) ?? 0;
      final email = _emailController.text;

      final newClient = Client(name, phoneNumber, email, _expirationDate);
      Hive.box<Client>('clients').add(newClient);

      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
      //Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Client')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name', icon: Icon(Icons.person)),
                validator: (value) => value!.isEmpty ? 'enter your name' : null,
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Phone Number', icon: Icon(Icons.phone)),
                validator: (value) => value!.isEmpty ? ' enter your phone number' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email', icon: Icon(Icons.email)),
                validator: (value) {
                  if (value == null || value.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return ' enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Expiration Date: ${_expirationDate.toLocal().toString().split(' ')[0]}",),
                  ElevatedButton(
                    onPressed: () => _pickDate(context),
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _addClient(context),
                child: const Text('Save Client'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Page for editing existing clients
class EditClientPage extends StatelessWidget {
  final Box<Client> clientBox;

  EditClientPage({super.key, required this.clientBox});

  void _editClient(BuildContext context, Client client) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditClientForm(client: client),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Client>>(
      valueListenable: clientBox.listenable(),
      builder: (context, box, _) {
        final clients = box.values.toList();
        return clients.isEmpty ? const Center(child: Text('No clients to edit.',style: TextStyle(fontSize: 40),)) : ListView.builder(
          itemCount: clients.length,
          itemBuilder: (context, index) {
            Client client = clients[index];
            return Container(
              decoration: BoxDecoration(
                // color: Colors.primaries[index % Colors.primaries.length],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
              ),

              child: ListTile(
                title: Text(client.name),
                subtitle: Text('Phone: ${client.phoneNumber}'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editClient(context, client),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// Form for editing a specific client
class EditClientForm extends StatefulWidget {
  final Client client;

  EditClientForm({super.key, required this.client});

  @override
  _EditClientFormState createState() => _EditClientFormState();
}

class _EditClientFormState extends State<EditClientForm> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late DateTime _expirationDate;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.client.name);
    _phoneController = TextEditingController(text: widget.client.phoneNumber.toString());
    _emailController = TextEditingController(text: widget.client.email);
    _expirationDate = widget.client.expirationDate;
  }

  void _updateClient(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final updatedClient = Client(
        _nameController.text,
        int.tryParse(_phoneController.text) ?? 0,
        _emailController.text,
        _expirationDate,
      );

      final box = Hive.box<Client>('clients');
      int index = box.values.toList().indexOf(widget.client);
      box.putAt(index, updatedClient); // Update the client

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Client')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name', icon: Icon(Icons.person)),
                validator: (value) => value!.isEmpty ? 'enter your name' : null,
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Phone Number', icon: Icon(Icons.phone)),
                validator: (value) => value!.isEmpty ? ' enter your phone number' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email', icon: Icon(Icons.email)),
                validator: (value) {
                  if (value == null || value.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return ' enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Expiration Date: ${_expirationDate.toLocal().toString().split(' ')[0]}"),
                  ElevatedButton(
                    onPressed: () {
                      // Show date picker here to pick a new expiration date
                      showDatePicker(
                        context: context,
                        initialDate: _expirationDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      ).then((date) {
                        if (date != null) {
                          setState(() {
                            _expirationDate = date;
                          });
                        }
                      });
                    },
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _updateClient(context),
                child: const Text('Update Client'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
