import 'package:flutter/material.dart';
import '../../../data/models/arts_model.dart';
import '../../../data/repositories/arts_repository.dart';

class ArtsScreen extends StatefulWidget {
  const ArtsScreen({Key? key}) : super(key: key);

  @override
  State<ArtsScreen> createState() => _ArtsScreenState();
}

class _ArtsScreenState extends State<ArtsScreen> {
  List<Art> arts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadArts();
  }

  Future<void> loadArts() async {
    arts = await ArtsRepository().loadArts();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Arts & Artisanat')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: arts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final art = arts[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Image.asset(
                        art.imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.black.withOpacity(0.6),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            art.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
