defmodule MithrilUI.AI.ComponentRegistry do
  @moduledoc """
  Registry of all Mithril UI components with AI-friendly metadata.

  Each component includes:
  - `name` - Component identifier
  - `module` - Elixir module path
  - `category` - Component category (actions, forms, feedback, etc.)
  - `description` - Brief description of the component
  - `use_when` - Scenarios when this component is appropriate
  - `do_not_use_when` - Scenarios when another component is better
  - `related` - Related components that work well together
  - `alternatives` - Alternative components for similar use cases
  - `variants` - Available style variants
  - `a11y` - Accessibility information
  """

  @components [
    # ==========================================================================
    # Actions
    # ==========================================================================
    %{
      name: :button,
      module: MithrilUI.Components.Button,
      category: :actions,
      description: "Interactive button for triggering actions and events",
      use_when: [
        "User needs to submit a form",
        "User needs to trigger an action or event",
        "User needs a call-to-action (CTA)",
        "User needs to confirm or cancel an operation"
      ],
      do_not_use_when: [
        "Simple navigation to another page (use Link instead)",
        "Toggling a boolean state (use Toggle instead)",
        "Selecting from multiple options (use Radio/Checkbox)"
      ],
      related: [:button_group, :dropdown, :link],
      alternatives: %{
        link: "For navigation without triggering an action",
        toggle: "For boolean on/off states",
        speed_dial: "For floating action button menus"
      },
      variants: ["primary", "secondary", "accent", "info", "success", "warning", "error", "ghost", "link", "outline"],
      sizes: ["xs", "sm", "md", "lg"],
      a11y: %{
        role: "button",
        keyboard: ["Enter", "Space"],
        focus_visible: true,
        aria_attributes: ["aria-pressed", "aria-disabled", "aria-busy"]
      }
    },
    %{
      name: :button_group,
      module: MithrilUI.Components.ButtonGroup,
      category: :actions,
      description: "Groups related buttons together with consistent styling",
      use_when: [
        "Multiple related actions should be grouped visually",
        "Segmented control for view options",
        "Toolbar with multiple action buttons"
      ],
      do_not_use_when: [
        "Single button (use Button instead)",
        "Radio selection (use Radio group instead)",
        "Tab navigation (use Tabs instead)"
      ],
      related: [:button, :tabs],
      alternatives: %{
        tabs: "For navigation between views",
        radio: "For mutually exclusive selection"
      },
      variants: ["horizontal", "vertical"],
      a11y: %{role: "group", keyboard: ["Tab"]}
    },
    %{
      name: :dropdown,
      module: MithrilUI.Components.Dropdown,
      category: :actions,
      description: "Dropdown menu for displaying a list of actions or options",
      use_when: [
        "Multiple actions should be grouped in a menu",
        "Space is limited and actions need to be collapsed",
        "User needs to select from a list of options"
      ],
      do_not_use_when: [
        "Form field selection (use Select instead)",
        "Single action (use Button instead)",
        "Primary navigation (use Navbar/Sidebar)"
      ],
      related: [:button, :select, :navbar],
      alternatives: %{
        select: "For form field selection",
        popover: "For rich content on hover/click"
      },
      variants: ["top", "bottom", "left", "right", "hover"],
      a11y: %{role: "menu", keyboard: ["Enter", "Space", "ArrowUp", "ArrowDown", "Escape"]}
    },

    # ==========================================================================
    # Forms
    # ==========================================================================
    %{
      name: :input,
      module: MithrilUI.Components.Input,
      category: :forms,
      description: "Text input field for collecting user data",
      use_when: [
        "Collecting single-line text input",
        "Email, password, or number input",
        "Search field input"
      ],
      do_not_use_when: [
        "Multi-line text (use Textarea instead)",
        "Selection from options (use Select/Radio)",
        "File upload (use FileInput instead)"
      ],
      related: [:textarea, :select, :checkbox],
      alternatives: %{
        textarea: "For multi-line text input",
        select: "For selection from predefined options"
      },
      variants: ["bordered", "ghost", "primary", "secondary", "accent", "info", "success", "warning", "error"],
      sizes: ["xs", "sm", "md", "lg"],
      a11y: %{role: "textbox", keyboard: ["all"], aria_attributes: ["aria-invalid", "aria-describedby"]}
    },
    %{
      name: :textarea,
      module: MithrilUI.Components.Textarea,
      category: :forms,
      description: "Multi-line text input for longer content",
      use_when: [
        "Collecting multi-line text input",
        "Comments or messages",
        "Description or bio fields"
      ],
      do_not_use_when: [
        "Single-line input (use Input instead)",
        "Rich text editing (use WYSIWYG editor)"
      ],
      related: [:input],
      alternatives: %{input: "For single-line text input"},
      variants: ["bordered", "ghost"],
      sizes: ["xs", "sm", "md", "lg"],
      a11y: %{role: "textbox", multiline: true}
    },
    %{
      name: :select,
      module: MithrilUI.Components.Select,
      category: :forms,
      description: "Dropdown selection field for choosing from options",
      use_when: [
        "User needs to select one option from a list",
        "Space is limited for displaying all options",
        "More than 5-7 options to choose from"
      ],
      do_not_use_when: [
        "Few options that fit on screen (use Radio instead)",
        "Multiple selections allowed (use Checkbox group)",
        "Custom dropdown content (use Dropdown)"
      ],
      related: [:radio, :checkbox, :dropdown],
      alternatives: %{
        radio: "For 2-5 visible options",
        checkbox: "For multiple selections"
      },
      variants: ["bordered", "ghost"],
      sizes: ["xs", "sm", "md", "lg"],
      a11y: %{role: "combobox", keyboard: ["Enter", "Space", "ArrowUp", "ArrowDown"]}
    },
    %{
      name: :checkbox,
      module: MithrilUI.Components.Checkbox,
      category: :forms,
      description: "Checkbox input for boolean or multiple selection",
      use_when: [
        "User can select multiple options",
        "Boolean yes/no or agree/disagree",
        "Enable/disable features"
      ],
      do_not_use_when: [
        "Mutually exclusive options (use Radio instead)",
        "On/off toggle with instant effect (use Toggle)"
      ],
      related: [:radio, :toggle],
      alternatives: %{
        radio: "For mutually exclusive selection",
        toggle: "For immediate on/off switching"
      },
      variants: ["primary", "secondary", "accent", "info", "success", "warning", "error"],
      sizes: ["xs", "sm", "md", "lg"],
      a11y: %{role: "checkbox", keyboard: ["Space"], aria_attributes: ["aria-checked"]}
    },
    %{
      name: :radio,
      module: MithrilUI.Components.Radio,
      category: :forms,
      description: "Radio button input for single selection from a group",
      use_when: [
        "User must select exactly one option",
        "2-5 options that should all be visible",
        "Options are mutually exclusive"
      ],
      do_not_use_when: [
        "Multiple selections allowed (use Checkbox)",
        "Many options (use Select instead)",
        "Toggle between two states (use Toggle)"
      ],
      related: [:checkbox, :select, :toggle],
      alternatives: %{
        select: "For many options in limited space",
        checkbox: "For multiple selections"
      },
      variants: ["primary", "secondary", "accent", "info", "success", "warning", "error"],
      sizes: ["xs", "sm", "md", "lg"],
      a11y: %{role: "radio", keyboard: ["ArrowUp", "ArrowDown", "ArrowLeft", "ArrowRight"]}
    },
    %{
      name: :toggle,
      module: MithrilUI.Components.Toggle,
      category: :forms,
      description: "Toggle switch for boolean on/off states",
      use_when: [
        "Immediate on/off switching",
        "Settings that take effect immediately",
        "Binary state changes"
      ],
      do_not_use_when: [
        "Form submission required (use Checkbox)",
        "Multiple options (use Radio/Checkbox)"
      ],
      related: [:checkbox],
      alternatives: %{checkbox: "For form submission with confirmation"},
      variants: ["primary", "secondary", "accent", "info", "success", "warning", "error"],
      sizes: ["xs", "sm", "md", "lg"],
      a11y: %{role: "switch", keyboard: ["Space"], aria_attributes: ["aria-checked"]}
    },
    %{
      name: :range,
      module: MithrilUI.Components.Range,
      category: :forms,
      description: "Slider input for selecting a value within a range",
      use_when: [
        "Selecting a numeric value within a range",
        "Volume, brightness, or similar controls",
        "Price or quantity ranges"
      ],
      do_not_use_when: [
        "Precise number input needed (use Input type=number)",
        "Discrete options (use Radio/Select)"
      ],
      related: [:input, :progress],
      alternatives: %{input: "For precise number entry"},
      variants: ["primary", "secondary", "accent", "info", "success", "warning", "error"],
      sizes: ["xs", "sm", "md", "lg"],
      a11y: %{role: "slider", keyboard: ["ArrowLeft", "ArrowRight", "Home", "End"]}
    },
    %{
      name: :file_input,
      module: MithrilUI.Components.FileInput,
      category: :forms,
      description: "File upload input for selecting files",
      use_when: [
        "User needs to upload files",
        "Image, document, or media uploads",
        "Single or multiple file selection"
      ],
      do_not_use_when: [
        "Text input (use Input/Textarea)",
        "Drag and drop is required (use custom dropzone)"
      ],
      related: [:input],
      alternatives: %{},
      variants: ["bordered", "ghost", "primary", "secondary"],
      sizes: ["xs", "sm", "md", "lg"],
      a11y: %{role: "button", keyboard: ["Enter", "Space"]}
    },

    # ==========================================================================
    # Feedback
    # ==========================================================================
    %{
      name: :alert,
      module: MithrilUI.Components.Alert,
      category: :feedback,
      description: "Alert message for displaying important information",
      use_when: [
        "Displaying success, error, warning, or info messages",
        "Important notifications that stay visible",
        "Form validation feedback"
      ],
      do_not_use_when: [
        "Temporary notifications (use Toast instead)",
        "Modal confirmation needed (use Modal)"
      ],
      related: [:toast, :banner],
      alternatives: %{
        toast: "For temporary, dismissible notifications",
        banner: "For page-wide announcements"
      },
      variants: ["info", "success", "warning", "error"],
      a11y: %{role: "alert", aria_live: "polite"}
    },
    %{
      name: :toast,
      module: MithrilUI.Components.Toast,
      category: :feedback,
      description: "Temporary notification that auto-dismisses",
      use_when: [
        "Brief feedback on user actions",
        "Non-critical notifications",
        "Success/error messages that should auto-dismiss"
      ],
      do_not_use_when: [
        "Critical information that must be seen (use Alert/Modal)",
        "Actions required from user (use Modal)"
      ],
      related: [:alert, :modal],
      alternatives: %{
        alert: "For persistent messages",
        modal: "For messages requiring user action"
      },
      variants: ["info", "success", "warning", "error"],
      positions: ["top-start", "top-center", "top-end", "bottom-start", "bottom-center", "bottom-end"],
      a11y: %{role: "status", aria_live: "polite"}
    },
    %{
      name: :modal,
      module: MithrilUI.Components.Modal,
      category: :feedback,
      description: "Modal dialog for focused interactions",
      use_when: [
        "User action required before continuing",
        "Confirmation dialogs",
        "Complex forms that need focus"
      ],
      do_not_use_when: [
        "Simple notifications (use Alert/Toast)",
        "Side panel content (use Drawer)"
      ],
      related: [:drawer, :alert],
      alternatives: %{
        drawer: "For side panel interactions",
        alert: "For inline messages"
      },
      variants: ["responsive"],
      sizes: ["xs", "sm", "md", "lg", "xl", "full"],
      a11y: %{role: "dialog", keyboard: ["Escape", "Tab"], focus_trap: true}
    },
    %{
      name: :drawer,
      module: MithrilUI.Components.Drawer,
      category: :feedback,
      description: "Slide-out panel from the edge of the screen",
      use_when: [
        "Side navigation or filters",
        "Detail panels that supplement main content",
        "Forms or content that shouldn't block main view"
      ],
      do_not_use_when: [
        "Critical user decisions (use Modal)",
        "Simple notifications (use Toast)"
      ],
      related: [:modal, :sidebar],
      alternatives: %{
        modal: "For centered dialogs requiring action",
        sidebar: "For persistent navigation"
      },
      positions: ["left", "right", "top", "bottom"],
      a11y: %{role: "dialog", keyboard: ["Escape"]}
    },
    %{
      name: :progress,
      module: MithrilUI.Components.Progress,
      category: :feedback,
      description: "Progress indicator for loading or completion status",
      use_when: [
        "Showing progress of an operation",
        "File upload progress",
        "Multi-step process completion"
      ],
      do_not_use_when: [
        "Indeterminate loading (use Spinner)",
        "Background loading without progress info"
      ],
      related: [:spinner, :stepper],
      alternatives: %{
        spinner: "For indeterminate loading",
        stepper: "For discrete step progress"
      },
      variants: ["primary", "secondary", "accent", "info", "success", "warning", "error"],
      a11y: %{role: "progressbar", aria_attributes: ["aria-valuenow", "aria-valuemin", "aria-valuemax"]}
    },
    %{
      name: :spinner,
      module: MithrilUI.Components.Spinner,
      category: :feedback,
      description: "Loading spinner for indeterminate wait times",
      use_when: [
        "Loading state without known duration",
        "Async operation in progress",
        "Button or content loading state"
      ],
      do_not_use_when: [
        "Known progress percentage (use Progress)",
        "Full page loading (use Skeleton)"
      ],
      related: [:progress, :skeleton],
      alternatives: %{
        progress: "When progress can be measured",
        skeleton: "For content placeholder loading"
      },
      variants: ["primary", "secondary", "accent", "info", "success", "warning", "error"],
      sizes: ["xs", "sm", "md", "lg"],
      a11y: %{role: "status", aria_label: "Loading"}
    },
    %{
      name: :skeleton,
      module: MithrilUI.Components.Skeleton,
      category: :feedback,
      description: "Content placeholder skeleton for loading states",
      use_when: [
        "Content is loading and layout is known",
        "Improving perceived performance",
        "Placeholder for images, text, or cards"
      ],
      do_not_use_when: [
        "Simple loading state (use Spinner)",
        "Action in progress (use Progress)"
      ],
      related: [:spinner, :progress],
      alternatives: %{spinner: "For simple loading indicator"},
      shapes: ["text", "circle", "rect", "card"],
      a11y: %{role: "status", aria_busy: true}
    },

    # ==========================================================================
    # Data Display
    # ==========================================================================
    %{
      name: :card,
      module: MithrilUI.Components.Card,
      category: :data_display,
      description: "Container for grouping related content",
      use_when: [
        "Grouping related content together",
        "Product cards, user profiles",
        "Content that benefits from visual separation"
      ],
      do_not_use_when: [
        "Simple list items (use ListGroup)",
        "Tabular data (use Table)"
      ],
      related: [:accordion, :list_group],
      alternatives: %{
        accordion: "For collapsible content sections",
        table: "For structured data rows"
      },
      variants: ["bordered", "compact", "side", "glass"],
      a11y: %{role: "article"}
    },
    %{
      name: :table,
      module: MithrilUI.Components.Table,
      category: :data_display,
      description: "Table for displaying structured tabular data",
      use_when: [
        "Displaying structured data with rows and columns",
        "Data comparison across multiple attributes",
        "Sortable, filterable data lists"
      ],
      do_not_use_when: [
        "Simple lists (use ListGroup)",
        "Card-based layouts (use Card grid)"
      ],
      related: [:list_group, :pagination],
      alternatives: %{
        list_group: "For simple item lists",
        card: "For visual content display"
      },
      variants: ["zebra", "pinned-rows", "pinned-cols", "compact"],
      sizes: ["xs", "sm", "md", "lg"],
      a11y: %{role: "table", keyboard: ["Tab", "ArrowKeys"]}
    },
    %{
      name: :avatar,
      module: MithrilUI.Components.Avatar,
      category: :data_display,
      description: "User avatar image or placeholder",
      use_when: [
        "Displaying user profile images",
        "Representing users in lists or comments",
        "Group member displays"
      ],
      do_not_use_when: [
        "Decorative images (use regular img)",
        "Product images (use Card with image)"
      ],
      related: [:badge, :indicator],
      alternatives: %{},
      shapes: ["circle", "squircle", "square"],
      sizes: ["xs", "sm", "md", "lg", "xl"],
      a11y: %{role: "img", aria_attributes: ["alt"]}
    },
    %{
      name: :badge,
      module: MithrilUI.Components.Badge,
      category: :data_display,
      description: "Small label for status or counts",
      use_when: [
        "Status indicators (new, sale, etc.)",
        "Notification counts",
        "Category labels or tags"
      ],
      do_not_use_when: [
        "Long text content (use Alert)",
        "Interactive elements (use Button)"
      ],
      related: [:indicator, :alert],
      alternatives: %{
        indicator: "For positional status dots",
        alert: "For longer messages"
      },
      variants: ["neutral", "primary", "secondary", "accent", "info", "success", "warning", "error", "ghost", "outline"],
      sizes: ["xs", "sm", "md", "lg"],
      a11y: %{role: "status"}
    },
    %{
      name: :accordion,
      module: MithrilUI.Components.Accordion,
      category: :data_display,
      description: "Collapsible content sections",
      use_when: [
        "FAQ sections",
        "Collapsible content to save space",
        "Progressive disclosure of information"
      ],
      do_not_use_when: [
        "Tabbed content (use Tabs)",
        "Always-visible content (use Card)"
      ],
      related: [:tabs, :card],
      alternatives: %{
        tabs: "For switching between views",
        card: "For always-visible content"
      },
      variants: ["arrow", "plus", "bordered", "join"],
      a11y: %{role: "region", keyboard: ["Enter", "Space"]}
    },
    %{
      name: :list_group,
      module: MithrilUI.Components.ListGroup,
      category: :data_display,
      description: "Vertical list of items",
      use_when: [
        "Simple list of items",
        "Navigation menus",
        "Settings or options lists"
      ],
      do_not_use_when: [
        "Complex data (use Table)",
        "Card-style items (use Card grid)"
      ],
      related: [:table, :sidebar],
      alternatives: %{
        table: "For structured data",
        card: "For rich content items"
      },
      variants: ["bordered", "horizontal"],
      a11y: %{role: "list"}
    },
    %{
      name: :timeline,
      module: MithrilUI.Components.Timeline,
      category: :data_display,
      description: "Vertical timeline for sequential events",
      use_when: [
        "Showing chronological events",
        "Order or shipping status",
        "Activity history or changelog"
      ],
      do_not_use_when: [
        "Step-by-step progress (use Stepper)",
        "Non-sequential data (use ListGroup)"
      ],
      related: [:stepper, :list_group],
      alternatives: %{
        stepper: "For interactive step progress",
        list_group: "For non-chronological lists"
      },
      variants: ["vertical", "horizontal", "snap", "compact"],
      a11y: %{role: "list"}
    },

    # ==========================================================================
    # Navigation
    # ==========================================================================
    %{
      name: :navbar,
      module: MithrilUI.Components.Navbar,
      category: :navigation,
      description: "Top navigation bar for main site navigation",
      use_when: [
        "Main site header navigation",
        "Branding and primary navigation",
        "Responsive navigation with mobile menu"
      ],
      do_not_use_when: [
        "Side navigation (use Sidebar)",
        "Tab navigation (use Tabs)"
      ],
      related: [:sidebar, :breadcrumb],
      alternatives: %{
        sidebar: "For side navigation",
        bottom_navigation: "For mobile bottom nav"
      },
      a11y: %{role: "navigation", keyboard: ["Tab"]}
    },
    %{
      name: :sidebar,
      module: MithrilUI.Components.Sidebar,
      category: :navigation,
      description: "Side navigation panel",
      use_when: [
        "Complex app navigation",
        "Dashboard side menus",
        "Nested navigation structure"
      ],
      do_not_use_when: [
        "Simple top navigation (use Navbar)",
        "Temporary side panel (use Drawer)"
      ],
      related: [:navbar, :drawer],
      alternatives: %{
        navbar: "For top navigation",
        drawer: "For temporary side panels"
      },
      a11y: %{role: "navigation"}
    },
    %{
      name: :breadcrumb,
      module: MithrilUI.Components.Breadcrumb,
      category: :navigation,
      description: "Breadcrumb navigation for showing location",
      use_when: [
        "Deep nested page structures",
        "E-commerce category navigation",
        "Showing user's location in hierarchy"
      ],
      do_not_use_when: [
        "Flat site structure",
        "Primary navigation (use Navbar)"
      ],
      related: [:navbar, :tabs],
      alternatives: %{},
      a11y: %{role: "navigation", aria_label: "Breadcrumb"}
    },
    %{
      name: :tabs,
      module: MithrilUI.Components.Tabs,
      category: :navigation,
      description: "Tab navigation for switching between content panels",
      use_when: [
        "Switching between related content views",
        "Organizing content into sections",
        "Reducing page complexity"
      ],
      do_not_use_when: [
        "Separate pages (use regular navigation)",
        "Collapsible content (use Accordion)"
      ],
      related: [:accordion, :button_group],
      alternatives: %{
        accordion: "For collapsible sections",
        navbar: "For page navigation"
      },
      variants: ["bordered", "lifted", "boxed"],
      sizes: ["xs", "sm", "md", "lg"],
      a11y: %{role: "tablist", keyboard: ["ArrowLeft", "ArrowRight", "Home", "End"]}
    },
    %{
      name: :pagination,
      module: MithrilUI.Components.Pagination,
      category: :navigation,
      description: "Pagination controls for navigating pages",
      use_when: [
        "Large data sets split into pages",
        "Search results pagination",
        "Table data pagination"
      ],
      do_not_use_when: [
        "Infinite scroll",
        "Small data sets that fit on one page"
      ],
      related: [:table],
      alternatives: %{},
      sizes: ["xs", "sm", "md", "lg"],
      a11y: %{role: "navigation", aria_label: "Pagination"}
    },
    %{
      name: :bottom_navigation,
      module: MithrilUI.Components.BottomNavigation,
      category: :navigation,
      description: "Mobile bottom navigation bar",
      use_when: [
        "Mobile app-style navigation",
        "Fixed bottom navigation on mobile",
        "3-5 primary navigation items"
      ],
      do_not_use_when: [
        "Desktop navigation (use Navbar)",
        "Complex navigation (use Sidebar)"
      ],
      related: [:navbar, :tabs],
      alternatives: %{
        navbar: "For desktop top navigation",
        tabs: "For content switching"
      },
      a11y: %{role: "navigation"}
    },

    # ==========================================================================
    # Overlays
    # ==========================================================================
    %{
      name: :tooltip,
      module: MithrilUI.Components.Tooltip,
      category: :overlays,
      description: "Small popup with hint text on hover/focus",
      use_when: [
        "Brief explanations on hover",
        "Icon button labels",
        "Abbreviated text expansion"
      ],
      do_not_use_when: [
        "Interactive content (use Popover)",
        "Critical information (display inline)",
        "Touch-only interfaces"
      ],
      related: [:popover],
      alternatives: %{popover: "For interactive or rich content"},
      positions: ["top", "bottom", "left", "right"],
      variants: ["primary", "secondary", "accent", "info", "success", "warning", "error"],
      a11y: %{role: "tooltip", keyboard: ["focus"]}
    },
    %{
      name: :popover,
      module: MithrilUI.Components.Popover,
      category: :overlays,
      description: "Rich content popup triggered on click or hover",
      use_when: [
        "Interactive content in overlay",
        "Rich previews or details",
        "Secondary actions or information"
      ],
      do_not_use_when: [
        "Simple text hint (use Tooltip)",
        "Full dialogs (use Modal)"
      ],
      related: [:tooltip, :dropdown, :modal],
      alternatives: %{
        tooltip: "For simple text hints",
        modal: "For full dialogs"
      },
      positions: ["top", "bottom", "left", "right"],
      a11y: %{role: "dialog", keyboard: ["Escape"]}
    },

    # ==========================================================================
    # Typography
    # ==========================================================================
    %{
      name: :heading,
      module: MithrilUI.Components.Heading,
      category: :typography,
      description: "Semantic heading elements (h1-h6)",
      use_when: [
        "Page titles and section headers",
        "Establishing content hierarchy",
        "SEO-important headings"
      ],
      do_not_use_when: [
        "Regular text (use Text)",
        "Styling without semantic meaning"
      ],
      related: [:text],
      alternatives: %{text: "For regular paragraph text"},
      levels: [1, 2, 3, 4, 5, 6],
      a11y: %{role: "heading", aria_level: "1-6"}
    },
    %{
      name: :text,
      module: MithrilUI.Components.Text,
      category: :typography,
      description: "Styled text for paragraphs and inline content",
      use_when: [
        "Body text and paragraphs",
        "Styled inline text",
        "Text with specific colors or sizes"
      ],
      do_not_use_when: [
        "Headings (use Heading)",
        "Code snippets (use Code)"
      ],
      related: [:heading, :link],
      alternatives: %{heading: "For section headings"},
      sizes: ["xs", "sm", "base", "lg", "xl", "2xl"],
      a11y: %{}
    },
    %{
      name: :link,
      module: MithrilUI.Components.Link,
      category: :typography,
      description: "Anchor link for navigation",
      use_when: [
        "Navigation to other pages",
        "External links",
        "In-page anchor links"
      ],
      do_not_use_when: [
        "Triggering actions (use Button)",
        "Form submission (use Button type=submit)"
      ],
      related: [:button],
      alternatives: %{button: "For actions without navigation"},
      variants: ["primary", "secondary", "accent", "neutral", "hover"],
      a11y: %{role: "link", keyboard: ["Enter"]}
    },
    %{
      name: :blockquote,
      module: MithrilUI.Components.Blockquote,
      category: :typography,
      description: "Styled quotation block",
      use_when: [
        "Displaying quotes or citations",
        "Testimonials",
        "Highlighted text excerpts"
      ],
      do_not_use_when: [
        "Code blocks (use Code)",
        "Regular content (use Text)"
      ],
      related: [:text],
      alternatives: %{},
      a11y: %{role: "blockquote"}
    },
    %{
      name: :code,
      module: MithrilUI.Components.Code,
      category: :typography,
      description: "Code display for inline and block code",
      use_when: [
        "Displaying code snippets",
        "Inline code references",
        "Terminal commands"
      ],
      do_not_use_when: [
        "Regular text (use Text)",
        "Keyboard shortcuts (use Kbd)"
      ],
      related: [:kbd, :clipboard],
      alternatives: %{kbd: "For keyboard shortcuts"},
      variants: ["inline", "block", "mockup"],
      a11y: %{role: "code"}
    },
    %{
      name: :kbd,
      module: MithrilUI.Components.Kbd,
      category: :typography,
      description: "Keyboard key display",
      use_when: [
        "Displaying keyboard shortcuts",
        "Key combinations",
        "Documentation of keyboard controls"
      ],
      do_not_use_when: [
        "Code snippets (use Code)",
        "Regular text (use Text)"
      ],
      related: [:code],
      alternatives: %{code: "For code snippets"},
      sizes: ["xs", "sm", "md", "lg"],
      a11y: %{role: "text"}
    },

    # ==========================================================================
    # Extended
    # ==========================================================================
    %{
      name: :rating,
      module: MithrilUI.Components.Rating,
      category: :extended,
      description: "Star rating display and input",
      use_when: [
        "Product or service ratings",
        "User reviews and feedback",
        "Rating input collection"
      ],
      do_not_use_when: [
        "Numeric input (use Input or Range)",
        "Binary like/dislike (use Toggle)"
      ],
      related: [:range, :toggle],
      alternatives: %{range: "For continuous value selection"},
      shapes: ["star", "star-2", "heart"],
      a11y: %{role: "radiogroup"}
    },
    %{
      name: :stepper,
      module: MithrilUI.Components.Stepper,
      category: :extended,
      description: "Step progress indicator for multi-step processes",
      use_when: [
        "Multi-step forms or wizards",
        "Order/checkout process",
        "Onboarding flows"
      ],
      do_not_use_when: [
        "Linear progress (use Progress)",
        "Chronological events (use Timeline)"
      ],
      related: [:progress, :timeline],
      alternatives: %{
        progress: "For continuous progress",
        timeline: "For chronological events"
      },
      orientations: ["horizontal", "vertical"],
      a11y: %{role: "list"}
    },
    %{
      name: :indicator,
      module: MithrilUI.Components.Indicator,
      category: :extended,
      description: "Positional indicator dot or badge",
      use_when: [
        "Status dots on avatars",
        "Notification badges",
        "Online/offline indicators"
      ],
      do_not_use_when: [
        "Standalone badge (use Badge)",
        "Alert messages (use Alert)"
      ],
      related: [:badge, :avatar],
      alternatives: %{badge: "For standalone labels"},
      positions: ["top", "middle", "bottom", "start", "center", "end"],
      a11y: %{role: "status"}
    },
    %{
      name: :chat_bubble,
      module: MithrilUI.Components.ChatBubble,
      category: :extended,
      description: "Chat message bubble for conversations",
      use_when: [
        "Chat interfaces",
        "Message threads",
        "Comment displays"
      ],
      do_not_use_when: [
        "Regular text (use Text)",
        "Alerts or notifications (use Alert)"
      ],
      related: [:avatar, :indicator],
      alternatives: %{},
      positions: ["start", "end"],
      colors: ["primary", "secondary", "accent", "info", "success", "warning", "error"],
      a11y: %{role: "log"}
    },
    %{
      name: :footer,
      module: MithrilUI.Components.Footer,
      category: :extended,
      description: "Page footer with navigation and info",
      use_when: [
        "Site-wide footer",
        "Copyright and legal links",
        "Secondary navigation"
      ],
      do_not_use_when: [
        "Primary navigation (use Navbar)",
        "Inline content"
      ],
      related: [:navbar],
      alternatives: %{},
      a11y: %{role: "contentinfo"}
    },
    %{
      name: :banner,
      module: MithrilUI.Components.Banner,
      category: :extended,
      description: "Page-wide announcement banner",
      use_when: [
        "Site-wide announcements",
        "Cookie consent notices",
        "Promotional messages"
      ],
      do_not_use_when: [
        "Contextual alerts (use Alert)",
        "Temporary messages (use Toast)"
      ],
      related: [:alert, :toast],
      alternatives: %{
        alert: "For contextual inline alerts",
        toast: "For temporary notifications"
      },
      variants: ["info", "success", "warning", "error"],
      a11y: %{role: "banner"}
    },
    %{
      name: :carousel,
      module: MithrilUI.Components.Carousel,
      category: :extended,
      description: "Image or content carousel/slider",
      use_when: [
        "Image galleries with horizontal scrolling",
        "Product image sliders",
        "Testimonial rotators"
      ],
      do_not_use_when: [
        "Grid image display (use Gallery)",
        "Tabs or content switching (use Tabs)"
      ],
      related: [:gallery, :tabs],
      alternatives: %{
        gallery: "For grid layouts",
        tabs: "For content switching"
      },
      snaps: ["start", "center", "end"],
      orientations: ["horizontal", "vertical"],
      a11y: %{role: "region", keyboard: ["ArrowLeft", "ArrowRight"]}
    },
    %{
      name: :gallery,
      module: MithrilUI.Components.Gallery,
      category: :extended,
      description: "Image gallery grid layout",
      use_when: [
        "Photo galleries",
        "Portfolio displays",
        "Product image grids"
      ],
      do_not_use_when: [
        "Horizontal scrolling (use Carousel)",
        "Single images"
      ],
      related: [:carousel, :card],
      alternatives: %{carousel: "For horizontal scrolling"},
      layouts: ["grid", "masonry", "featured", "quad"],
      columns: [1, 2, 3, 4, 5, 6],
      a11y: %{role: "list"}
    },

    # ==========================================================================
    # Utility
    # ==========================================================================
    %{
      name: :theme_switcher,
      module: MithrilUI.Components.ThemeSwitcher,
      category: :utility,
      description: "Theme selection dropdown or toggle",
      use_when: [
        "User theme preferences",
        "Dark/light mode switching",
        "Multi-theme applications"
      ],
      do_not_use_when: [
        "Fixed theme applications",
        "Simple toggle (use Toggle component)"
      ],
      related: [:dropdown, :toggle],
      alternatives: %{toggle: "For simple dark/light toggle"},
      a11y: %{role: "listbox"}
    },
    %{
      name: :clipboard,
      module: MithrilUI.Components.Clipboard,
      category: :utility,
      description: "Copy to clipboard functionality",
      use_when: [
        "Code snippets to copy",
        "API keys or tokens",
        "Share URLs"
      ],
      do_not_use_when: [
        "Regular text display (use Text)",
        "Editable input (use Input)"
      ],
      related: [:code, :input],
      alternatives: %{},
      a11y: %{role: "button"}
    },
    %{
      name: :speed_dial,
      module: MithrilUI.Components.SpeedDial,
      category: :utility,
      description: "Floating action button with expandable menu",
      use_when: [
        "Primary floating action button",
        "Quick access to multiple actions",
        "Mobile-style FAB menus"
      ],
      do_not_use_when: [
        "Regular action buttons (use Button)",
        "Dropdown menus (use Dropdown)"
      ],
      related: [:button, :dropdown],
      alternatives: %{
        button: "For single actions",
        dropdown: "For positioned menus"
      },
      positions: ["bottom-right", "bottom-left", "top-right", "top-left"],
      orientations: ["vertical", "horizontal"],
      a11y: %{role: "menu", keyboard: ["Enter", "Space", "Escape"]}
    }
  ]

  @doc """
  Returns all component metadata.
  """
  def all_components, do: @components

  @doc """
  Returns component metadata by name.
  """
  def get_component(name) when is_atom(name) do
    Enum.find(@components, &(&1.name == name))
  end

  def get_component(name) when is_binary(name) do
    get_component(String.to_existing_atom(name))
  rescue
    ArgumentError -> nil
  end

  @doc """
  Returns all components in a specific category.
  """
  def by_category(category) when is_atom(category) do
    Enum.filter(@components, &(&1.category == category))
  end

  @doc """
  Returns list of all categories.
  """
  def categories do
    @components
    |> Enum.map(& &1.category)
    |> Enum.uniq()
    |> Enum.sort()
  end

  @doc """
  Returns list of all component names.
  """
  def component_names do
    Enum.map(@components, & &1.name)
  end
end
