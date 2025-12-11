import 'package:flutter/material.dart';
import '../../../data/models/site_model.dart';
import '../../../data/repositories/site_repository.dart';
import 'site_detail_screen.dart';

class HeritageScreen extends StatefulWidget {
  const HeritageScreen({Key? key}) : super(key: key);

  @override
  State<HeritageScreen> createState() => _HeritageScreenState();
}

class _HeritageScreenState extends State<HeritageScreen> {
  List<Site> sites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSites();
  }

  Future<void> loadSites() async {
    sites = await SiteRepository().loadSites();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patrimoine Béninois'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sites.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final site = sites[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SiteDetailScreen(site: site),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        Image.asset(
                          site.imageUrl,
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
                              site.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
