# Updating Publication Links

## When Your Paper is Published

Follow these steps to update the placeholder links in the NeuroInsight landing page with your actual publication information.

## Step 1: Locate the Research Section

In `research.html`, find the main publication section (around line 50-100):

```html
<!-- Research Section -->
<section id="research" class="py-20 bg-white">
```

## Step 2: Update the Main Paper Link

**Current placeholder:**
```html
<a href="#"
   target="_blank"
   class="inline-flex items-center gap-2 bg-blue-800 text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-900 transition">
```

**Replace with your DOI:**
```html
<a href="https://doi.org/10.xxxx/neuroinsight-paper"
   target="_blank"
   class="inline-flex items-center gap-2 bg-blue-800 text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-900 transition">
```

## Step 3: Update the Abstract Link

**Current placeholder:**
```html
<a href="#"
   target="_blank"
   class="inline-flex items-center gap-2 border-2 border-blue-800 text-blue-800 px-6 py-3 rounded-lg font-semibold hover:bg-blue-800 hover:text-white transition">
```

**Replace with abstract URL:**
```html
<a href="https://pubmed.ncbi.nlm.nih.gov/xxxxx/"
   target="_blank"
   class="inline-flex items-center gap-2 border-2 border-blue-800 text-blue-800 px-6 py-3 rounded-lg font-semibold hover:bg-blue-800 hover:text-white transition">
```

## Step 4: Update Paper Information

**Current placeholder text:**
```html
<h3 class="text-2xl font-bold text-gray-900 mb-2">Published Research Paper</h3>
<p class="text-gray-600 mb-4">
    NeuroInsight: Automated Hippocampal Volumetric Analysis for Clinical Research.
    Validated methodology for T1-weighted MRI processing and asymmetry detection.
</p>
```

**Update with your actual paper details:**
```html
<h3 class="text-2xl font-bold text-gray-900 mb-2">[Your Paper Title]</h3>
<p class="text-gray-600 mb-4">
    [Brief description of your paper's findings and methodology]
</p>
```

## Step 5: Update Additional Resources (Optional)

If you have additional publications or resources, update these placeholder links:

```html
<!-- Clinical Validation Study -->
<a href="#" class="text-blue-800 hover:text-blue-900 font-medium text-sm">
    View Study →
</a>

<!-- Technical Methodology -->
<a href="#" class="text-blue-800 hover:text-blue-900 font-medium text-sm">
    Technical Details →
</a>
```

## Common Publication URLs

### Academic Journals
- **PubMed**: `https://pubmed.ncbi.nlm.nih.gov/PMCxxxxx/`
- **DOI**: `https://doi.org/10.xxxx/xxxxx`
- **Journal Website**: Check publisher's site

### Preprints
- **bioRxiv**: `https://www.biorxiv.org/content/10.xxxx`
- **arXiv**: `https://arxiv.org/abs/xxxxx`
- **medRxiv**: `https://www.medrxiv.org/content/10.xxxx`

## Step 6: Remove Placeholder Notice

**Remove this section after updating:**
```html
<div class="mt-4 p-4 bg-blue-50 rounded-lg border-l-4 border-blue-800">
    <p class="text-sm text-blue-800 font-medium">
        Placeholder Link: Replace "#" with the actual DOI or publication URL when available.
    </p>
    <p class="text-sm text-gray-600 mt-1">
        Example: "https://doi.org/10.xxxx/neuroinsight-paper" or "https://pubmed.ncbi.nlm.nih.gov/xxxxx/"
    </p>
</div>
```

## Step 7: Test the Links

After updating:
1. Start the local server: `python3 -m http.server 8080`
2. Visit: `http://localhost:8080`
3. Click the "Research" navigation link
4. Test both "Read Full Paper" and "View Abstract" links
5. Verify they open your publication correctly

## Checklist

- [ ] Updated main paper link with DOI
- [ ] Updated abstract link with PubMed/PMC URL
- [ ] Updated paper title and description
- [ ] Removed placeholder notice
- [ ] Tested links work correctly
- [ ] Updated README.md and PROJECT_DESCRIPTION.md if needed

## Tips

1. **Use DOI when possible** - it's permanent and reliable
2. **Include both full paper and abstract links** if available
3. **Update the description** to accurately reflect your paper's content
4. **Test on multiple browsers** to ensure links work
5. **Consider adding publication date** to the description

## Need Help?

If you need assistance updating the links or formatting the publication information, check the README.md file for contact information or refer to the project documentation.

---

Congratulations on your publication!
