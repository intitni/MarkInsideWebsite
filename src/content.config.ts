import { defineCollection, z } from "astro:content";
import { docsLoader } from "@astrojs/starlight/loaders";
import { docsSchema } from "@astrojs/starlight/schema";

export const collections = {
  docs: defineCollection({
    loader: docsLoader(),
    schema: docsSchema({
      extend: z.object({
        homePage: z.boolean().optional(),
        hideHeader: z.boolean().optional(),
        hideTitle: z.boolean().optional(),
        redirectSlug: z.string().optional(),
        changelog: z
          .object({
            previousVersion: z.string().optional(),
            previousTag: z.string().optional(),
          })
          .optional(),
      }),
    }),
  }),
};
