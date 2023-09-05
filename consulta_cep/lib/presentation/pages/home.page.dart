import 'package:consulta_cep/data/services/address-api/memory-zip-code-api.service.dart';
import 'package:consulta_cep/data/services/address-search/viacep-search.service.dart';
import 'package:consulta_cep/domain/entities/address.entity.dart';
import 'package:consulta_cep/presentation/components/builders/dialog.builder.dart';
import 'package:consulta_cep/presentation/components/builders/zip-code-input.builder.dart';
import 'package:consulta_cep/presentation/components/card_address.widget.dart';
import 'package:consulta_cep/presentation/pages/form.page.dart';
import 'package:consulta_cep/presentation/presenters/home.presenter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final presenter =
      HomePresenter(AddressApiInMemoryService(), ViaCepSearchService());

  @override
  void initState() {
    presenter.findAll();
    super.initState();
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  _onDelete(Address address) {
    DialogBuilder.show(context).then((accept) {
      if (accept) {
        presenter.delete(address).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Endereço excluído com sucesso!'),
            ),
          );
        });
      }
    });
  }

  _onUpdate(Address address) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormPage(
          address: address,
        ),
      ),
    ).then((value) {
      if (value != null) {
        presenter.update(value);
      }
    });
  }

  _onCreate(context) async {
    final zipCode = await ZipCodeInputBuilder.show(context);

    if (zipCode == null) {
      return;
    }

    final address = await presenter.search(zipCode);

    if (address == null) {
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormPage(
          address: address,
        ),
      ),
    ).then((value) {
      if (value != null) {
        presenter.create(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Catalogo de CEPs'),
      ),
      body: ValueListenableBuilder(
          valueListenable: presenter,
          builder: (context, value, child) {
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemCount: value.length,
              itemBuilder: (context, index) => CardAddress(
                onDelete: _onDelete,
                onUpdate: _onUpdate,
                address: value[index],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Buscar CEP',
        onPressed: () => _onCreate(context),
        child: const Icon(Icons.search),
      ),
    );
  }
}
