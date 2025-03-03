// @ts-check
import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";
import starlightImageZoom from 'starlight-image-zoom'

// https://astro.build/config
export default defineConfig({
  integrations: [
    starlight({
      title: "UE12 - Introduction",
      social: {
        github: "https://github.com/ue12-p25/intro",
      },
      // for zoomable images
      plugins: [starlightImageZoom()],
      sidebar: [
        {
          label: "Introduction",
          items: [
            { label: "<tl;dr>", link: "/0-1-presentation-ue12-ue22" },
            { label: "Version longue", link: "/0-2-presentation-longue" },
          ],
        },
        {
          label: "Installation et configuration",
          items: [
            { label: "Installations", link: "/1-1-installations" },
            { label: "Cloner et lire le cours", link: "/1-2-clone-and-play" },
          ],
        },
        {
          label: "Les outils",
          items: [
            { label: "Le terminal", link: "/2-1-terminal-os" },
            { label: "Python", link: "/2-3-python" },
          ],
        },
        {
          label: "Compléments",
          items: [{ label: "Checklist", link: "/3-1-checklist" }],
        },
      ],
    }),
  ],
});
